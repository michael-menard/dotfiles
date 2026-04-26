# OpenCode Configuration

AI code editor with multiple provider support.

## Configuration

The `opencode.json` configures these providers:

### 🤖 OpenAI
- GPT-4o, GPT-4o-mini
- o1, o1-mini
- Requires: `OPENAI_API_KEY` in `~/.env`

### 🤖 Anthropic (Claude)
- Claude Sonnet 4, Claude Sonnet 3.5
- Claude Haiku 3.5
- Requires: `ANTHROPIC_API_KEY` in `~/.env`

### 🌐 OpenRouter
- Google Gemini 2.0 Flash, Gemini Pro 1.5
- DeepSeek Chat, DeepSeek Coder (cloud)
- Qwen 2.5 Coder 32B (cloud)
- Meta Llama 3.3 70B
- Mistral Large
- Requires: `OPENROUTER_API_KEY` in `~/.env`

### 🏠 Ollama (Local)
- Qwen 2.5 Coder (7B, 14B)
- DeepSeek Coder v2 (16B)
- CodeLlama (13B)
- Requires: Ollama running on `localhost:11434`

## Setup

### 1. Install Dependencies

After stowing the opencode package:

```bash
cd ~/.config/opencode
bun install  # or npm install
```

This will install:
- `@opencode-ai/plugin` - Core OpenCode plugin
- `@ai-sdk/openai` - OpenAI provider
- `@ai-sdk/anthropic` - Anthropic provider
- `@ai-sdk/openai-compatible` - Ollama provider

### 2. Configure API Keys

Add your API keys to `~/.env`:

```bash
# ~/.env
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...
OPENROUTER_API_KEY=sk-or-...
```

These will be automatically loaded by your shell and used by OpenCode.

### 3. Install Ollama Models (Optional)

For local models, install them via Ollama:

```bash
ollama pull qwen2.5-coder:7b
ollama pull qwen2.5-coder:14b
ollama pull deepseek-coder-v2:16b
ollama pull codellama:13b
```

Start Ollama server:
```bash
ollama serve
```

## Usage

Use the zsh aliases defined in `.zshrc`:

### OpenAI
```bash
oc-4o          # GPT-4o (best reasoning)
oc-4o-mini     # GPT-4o mini (fast, cheap)
oc-o1          # o1 (advanced reasoning)
oc-o1-mini     # o1 mini (fast reasoning)
```

### Anthropic
```bash
oc-sonnet      # Claude Sonnet 4 (latest)
oc-sonnet35    # Claude Sonnet 3.5
oc-haiku       # Claude Haiku 3.5 (fast)
```

### OpenRouter
```bash
oc-gemini      # Google Gemini 2.0 Flash (fast)
oc-gemini-pro  # Google Gemini Pro 1.5
oc-deepseek-chat  # DeepSeek Chat (cloud)
oc-deepseek-or    # DeepSeek Coder (cloud)
oc-qwen-or     # Qwen 2.5 Coder 32B (cloud)
oc-llama       # Meta Llama 3.3 70B
oc-mistral     # Mistral Large
```

### OpenCode Hosted (Free)
```bash
oc-nano        # Fast free cloud model
oc-pickle      # OpenCode's own model
oc-minimax     # MiniMax free model
oc-trinity     # Trinity large model
```

### Local Ollama
```bash
oc-qwen        # Qwen 7B (fast)
oc-qwen14      # Qwen 14B (better)
oc-deepseek    # DeepSeek 16B
oc-codellama   # CodeLlama 13B
```

### Direct Usage
```bash
opencode --model openai/gpt-4o
opencode --model anthropic/claude-sonnet-4
opencode --model openrouter/gemini-flash
opencode --model ollama/qwen-local
```

## Files

### Tracked in Git
- `opencode.json` - Provider and model configuration
- `package.json.example` - Dependency template
- `README.md` - This file

### Not Tracked (Ignored)
- `package.json` - Installed dependencies list
- `bun.lock` / `package-lock.json` - Lock files
- `node_modules/` - Installed packages
- `.gitignore` - Local git ignore

## Troubleshooting

### API Keys Not Working
Verify they're loaded:
```bash
echo $OPENAI_API_KEY
echo $ANTHROPIC_API_KEY
echo $OPENROUTER_API_KEY
```

If empty, check `~/.env` exists and reload shell:
```bash
exec zsh
```

### Ollama Connection Failed
Check Ollama is running:
```bash
curl http://localhost:11434/api/tags
```

Start Ollama if needed:
```bash
ollama serve
```

### Missing Dependencies
Reinstall:
```bash
cd ~/.config/opencode
rm -rf node_modules
bun install  # or npm install
```

## Fresh Machine Setup

1. Stow the package: `cd ~/dotfiles && stow opencode`
2. Install dependencies: `cd ~/.config/opencode && bun install`
3. Add API keys to `~/.env`
4. (Optional) Install Ollama models: `ollama pull qwen2.5-coder:7b`

## Links

- [OpenCode Documentation](https://opencode.ai/docs)
- [OpenRouter](https://openrouter.ai/) - Unified API for many models
- [Ollama](https://ollama.ai/)
- [OpenAI API](https://platform.openai.com/)
- [Anthropic API](https://console.anthropic.com/)
