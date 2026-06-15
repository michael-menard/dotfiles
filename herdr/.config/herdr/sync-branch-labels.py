#!/usr/bin/env python3
"""Prefix each herdr workspace label with a compact branch tag: "tag · friendly".

Tag, derived from the active pane's git branch:
  - "#867"  if the branch carries an issue number (e.g. feat/867-foo)
  - "main"  for the default branch
  - the branch type otherwise (e.g. "chore" for chore/no-issue-foo)

Idempotent: the part after the first " · " is the stable friendly base, so
re-running only refreshes the tag. Branch comes from each workspace's active
pane cwd (`herdr pane list`) resolved with git.

Usage:
  sync-branch-labels.py            # dry run — prints proposed renames, changes nothing
  sync-branch-labels.py --apply    # actually rename
"""
import json
import re
import subprocess
import sys

SEP = " · "


def sh(args):
    return subprocess.run(args, capture_output=True, text=True).stdout.strip()


def tag_for(cwd):
    if not cwd:
        return None
    branch = sh(["git", "-C", cwd, "rev-parse", "--abbrev-ref", "HEAD"])
    if not branch:
        return None
    if branch in ("main", "master"):
        return branch
    m = re.search(r"(\d+)", branch)
    if m:
        return f"#{m.group(1)}"
    return branch.split("/", 1)[0]  # the type, e.g. "chore"


def main():
    apply = "--apply" in sys.argv

    panes = json.loads(sh(["herdr", "pane", "list"]))["result"]["panes"]
    workspaces = json.loads(sh(["herdr", "workspace", "list"]))["result"]["workspaces"]

    cwd_by_ws = {}
    for p in panes:
        cwd_by_ws.setdefault(p["workspace_id"], p.get("foreground_cwd") or p.get("cwd"))

    changed = False
    for ws in workspaces:
        wid, label = ws["workspace_id"], ws["label"]
        tag = tag_for(cwd_by_ws.get(wid))
        if not tag:
            print(f"  skip  {label!r}  (no git branch)")
            continue
        base = label.split(SEP, 1)[1] if SEP in label else label
        new = f"{tag}{SEP}{base}"
        if new == label:
            print(f"  ok    {label!r}")
            continue
        changed = True
        print(f"  {'rename' if apply else 'would'}  {label!r}  ->  {new!r}")
        if apply:
            sh(["herdr", "workspace", "rename", wid, new])

    if not apply and changed:
        print("\n(dry run) re-run with --apply to rename")


if __name__ == "__main__":
    main()
