/**
 * Ghostty Tab Notifications Extension
 *
 * Mirrors Claude Code's tab-title behaviour in Ghostty:
 *
 *   • Working  → "⏳ Pi — {session} — {cwd}"  + indeterminate progress bar on the tab
 *   • Done     → "🔔 Pi — {session} — {cwd}"  + BEL (triggers Ghostty's tab-attention dot)
 *   • Idle     → "Pi — {session} — {cwd}"     (on session start; done state persists until next action)
 *
 * The BEL (\x07) is what makes Ghostty put a notification indicator on the tab
 * when it is in the background — the same mechanism Claude Code uses.
 *
 * The OSC 9;4;3 sequence drives Ghostty's built-in tab progress bar, so you get
 * a visual "still working" cue even when the tab title is too narrow to read.
 *
 * Install  —  add to ~/.pi/agent/settings.json:
 *
 *   "extensions": ["~/.pi/extensions/ghostty-tab-notify.ts"]
 *
 * Or run ad-hoc:
 *
 *   pi -e ~/.pi/extensions/ghostty-tab-notify.ts
 */

import path from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";

/* ── terminal escape sequences ─────────────────────────────────────── */

const BEL = "\x07";
const OSC_PROGRESS_ACTIVE = "\x1b]9;4;3\x07"; // indeterminate progress
const OSC_PROGRESS_CLEAR = "\x1b]9;4;0\x07"; // clear progress

/* ── helpers ───────────────────────────────────────────────────────── */

type TabState = "idle" | "working" | "done";

const ICON: Record<TabState, string> = {
	idle: "",
	working: "⏳ ",
	done: "🔔 ",
};

function buildTitle(ctx: ExtensionContext, state: TabState): string {
	const cwdBasename = path.basename(ctx.cwd || ctx.sessionManager.getCwd() || "");
	const sessionName = ctx.sessionManager.getSessionName();
	const base = sessionName
		? `Pi — ${sessionName} — ${cwdBasename}`
		: `Pi — ${cwdBasename}`;
	return `${ICON[state]}${base}`;
}

function writeProgress(active: boolean): void {
	try {
		process.stdout.write(active ? OSC_PROGRESS_ACTIVE : OSC_PROGRESS_CLEAR);
	} catch {
		// stdout might be closed during shutdown — ignore
	}
}

function ringBell(): void {
	try {
		process.stdout.write(BEL);
	} catch {
		// ignore
	}
}

/* ── extension entry point ─────────────────────────────────────────── */

export default function (pi: ExtensionAPI) {
	let currentState: TabState = "idle";

	const setTitle = (ctx: ExtensionContext, state: TabState) => {
		currentState = state;
		ctx.ui.setTitle(buildTitle(ctx, state));
	};

	// ── session lifecycle ──────────────────────────────────────────────

	pi.on("session_start", async (_event, ctx) => {
		setTitle(ctx, "idle");
	});

	pi.on("session_info_changed", async (_event, ctx) => {
		// Session name or cwd changed — refresh title but keep current state icon.
		ctx.ui.setTitle(buildTitle(ctx, currentState));
	});

	pi.on("session_shutdown", async () => {
		writeProgress(false);
	});

	// ── agent work lifecycle ───────────────────────────────────────────

	pi.on("agent_start", async (_event, ctx) => {
		setTitle(ctx, "working");
		writeProgress(true);
	});

	pi.on("agent_end", async (_event, ctx) => {
		writeProgress(false);

		// Show "done" + ring the bell so Ghostty flags the tab.
		// The notification persists until the user sends the next message
		// (which fires agent_start and switches back to "working").
		setTitle(ctx, "done");
		ringBell();
	});

	pi.on("agent_settled", async (_event, _ctx) => {
		// Safety net: ensure progress is always cleared.
		writeProgress(false);
	});
}