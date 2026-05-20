<div align="center">

![MoodleVim Banner](https://github.com/user-attachments/assets/2310622a-536b-4083-b465-50ef50c9318e)

# MoodleVim

**A Neovim configuration built for Moodle PHP development.**

Fuzzy finding, Xdebug, Moodle coding standards, test running, and AI assistance — all wired up and ready to go.

[![Neovim](https://img.shields.io/badge/Neovim-0.10%2B-57A143?logo=neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Lua-5.1-2C2D72?logo=lua&logoColor=white)](https://www.lua.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

</div>

---

## Overview

MoodleVim is a Neovim distribution focused on the **Moodle PHP development** workflow. It ships with:

- Dual PHP LSP (Intelephense + PHPActor) with Moodle-aware formatting and linting
- One-command test running, cache purging, JS compilation, and cron
- Xdebug step debugging with a visual UI
- Scope-aware fuzzy finding across files, symbols, and grep
- A persistent multi-panel terminal and AI agent integration

Built on [lazy.nvim](https://github.com/folke/lazy.nvim), with sensible defaults, fully discoverable keymaps, and easy to extend.

> **Note:** MoodleVim is a configuration layer, not a replacement for the tools it bundles. Neovim, all plugins, language servers, and external tools (phpcs, phpstan, Xdebug, etc.) are independent projects maintained by their own authors. This config wires them together for the Moodle workflow — for anything specific to a tool's behaviour, consult its own documentation. Links to each tool and plugin are provided throughout this README.

---

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Features & Workflows](#features--workflows)
- [Plugins](#plugins)
- [LSP & Tooling](#lsp--tooling)
- [Commands](#commands)
- [Keymaps](#keymaps)
- [Configuration](#configuration)
- [Roadmap](#roadmap)
- [Contributing](#contributing)

---

## Requirements

| Requirement | Notes |
|-------------|-------|
| **Neovim >= 0.10** | |
| **Git** | |
| **Node.js** | Required by the Intelephense LSP |
| **PHP >= 7.4** in `$PATH` | |
| **Composer** in `$PATH` | |
| **ripgrep (`rg`)** | Required by file and grep pickers |
| **A Nerd Font** | Recommended: JetBrainsMono Nerd Font |
| A **clipboard provider** | `xclip`, `xsel`, `wl-clipboard`, or `pbcopy` |

The following tools are installed automatically via [Mason](https://github.com/williamboman/mason.nvim) (Neovim's tool installer) on first launch:

`intelephense` · `phpactor` · `phpcs` / `phpcbf` · `php-cs-fixer` · `phpstan` · `php-debug-adapter` · `lua-language-server` · `bash-language-server` · `stylua` · `selene` · `biome` · `beautysh`

---

## Installation

> **Back up your existing Neovim config before proceeding.**

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/davidherzlos/dotfiles
cp -r dotfiles/nvim/.config/nvim ~/.config/nvim
```

Open Neovim. lazy.nvim will bootstrap itself and install all plugins on first launch.

```
nvim
```

Mason will then install all LSP servers and tools in the background. Check progress with `:Mason`.

---

## Quick Start

You don't need to read the full docs to get productive. Here's everything you need to know on day one:

**Explore the config by pressing `Space`.** A popup shows all available actions grouped by category. Keep pressing keys to go deeper. Press `<Esc>` to cancel.

| You want to… | Press |
|--------------|-------|
| See everything available | `Space` |
| Find a file | `Space f f` |
| Search text in the project | `Space g g` |
| Open a recent file | `Space f l` |
| Switch between open buffers | `Space Space` |
| Go to definition | `Space s d` |
| Find references | `Space s r` |
| Rename a symbol | `Space r s` |
| Code actions (refactor, fix) | `Space r a` |
| Open a terminal | `Ctrl+\` |
| Run tests on current file | `:MoodleTestBuffer` |
| Toggle format on save | `:ConformToggle` |
| Start debugging (Xdebug) | `F5` |
| Toggle a breakpoint | `Space x b` |
| Open AI assistant | `Space a t` |
| Search all keymaps | `Space ?` |

**Five things worth knowing:**

1. `Space` is the leader key — it unlocks everything.
2. The popup that appears after pressing `Space` is your map. You never need to memorise keymaps.
3. Formatting is **off by default**. Run `:ConformToggle` once to turn it on for your session.
4. If you're in a Moodle project, the config detects it automatically — the right formatter, linter, and search scope are applied without any setup.
5. The `:Moodle*` commands (`:MoodleTestBuffer`, `:MoodlePurgeCaches`, etc.) are your shortcuts for the development loop. Type `:Moodle` and press `Tab` to see them all.

---

## Features & Workflows

### Moodle Project Detection

Open a Moodle project and everything adjusts automatically — the right formatter, the right LSP scope, the right search roots. File and grep pickers can be scoped to the plugin you are currently working on with a single keypress, so you are never searching the entire Moodle tree when you only care about one component.

### PHP Intelligence

Get completions, go-to-definition, references, hover docs, symbol rename, and code lens out of the box. Two PHP language servers power this: [Intelephense](https://intelephense.com) (a fast, feature-rich PHP LSP) and [PHPActor](https://phpactor.readthedocs.io) (a refactoring-focused PHP tool). Together they cover a full refactoring palette through code actions: extract method, introduce variable, implement interface, and more — all without leaving the editor.

Formatting is off by default so it never surprises you. Turn it on with `:ConformToggle` and every save will apply the right formatter for the project: `phpcbf` (the Moodle coding standard fixer) or `php-cs-fixer` (a general PHP formatter following Symfony rules) for everything else.

Linting runs silently in the background as you type using `phpcs` (PHP CodeSniffer), which checks your code against the active coding standard. Problems show up as gutter signs the moment you leave insert mode, keeping the writing flow uninterrupted.

| Filetype | Formatter | Linter |
|----------|-----------|--------|
| PHP — Moodle | `phpcbf` (Moodle Coding Style) | `phpcs` (PHP CodeSniffer) |
| PHP — other | `php-cs-fixer` (Symfony rules) | `phpcs` |
| JavaScript / JSON | `biome` (fast JS/JSON toolchain) | `biome` |
| Lua | `stylua` (opinionated Lua formatter) | `selene` (Lua linter) |
| Shell | `beautysh` (shell script formatter) | — |

### PHPStan on Demand

[PHPStan](https://phpstan.org) is a static analysis tool that catches bugs and type errors in PHP code without running it. Run it on the current file any time with `:PhpStan`. Findings land directly in the diagnostics panel and the quickfix list so you can jump through them like any other issue.

### Xdebug Step Debugging

[Xdebug](https://xdebug.org) is a PHP debugger that lets you pause execution, inspect variables, and step through code line by line. MoodleVim connects to it via the [Debug Adapter Protocol](https://microsoft.github.io/debug-adapter-protocol/) — the same standard VS Code uses — so the full debugging experience is available right inside Neovim. Set a breakpoint, hit `<F5>` to start listening, trigger your request, and step through live PHP execution. Two debug UIs are available — a classic split panel view and a compact winbar view — and both open and close automatically with each session. Log points, watch expressions, thread inspection, and a full control bar are all a keypress away.

### Fuzzy Finding

Find anything fast. Files, grep results, LSP symbols, open buffers, keymaps, help tags, installed plugins, and more are all one prefix away. Powered by [Snacks.nvim](https://github.com/folke/snacks.nvim) and [Telescope](https://github.com/nvim-telescope/telescope.nvim) — two popular Neovim fuzzy-finder frameworks — with custom layouts that feel right at home. Every file and grep picker is **scope-aware**: search the full project, the current Moodle plugin, your Neovim config, or the plugins directory — all with dedicated keys.

Two extra pickers make navigating large files effortless:

- **Buffer jump** (`<leader>jj`) — fuzzy-search every line of the current buffer with syntax highlighting in the results. Moving through matches scrolls the real buffer in sync so you always see context.
- **Live multigrep** — search by pattern and narrow by file glob in the same prompt. Type `render_course  **/course/**` to instantly scope [ripgrep](https://github.com/BurntSushi/ripgrep) to a path subtree.

### Git

Review, stage, and resolve conflicts without leaving Neovim. Toggle an inline diff overlay to see what changed in the current file, open side-by-side diff splits against the worktree or the index, or launch a 3-way merge view for conflict resolution. Any diff can be sent to the quickfix or location list so you can walk through every changed file with `<C-j>/<C-k>`.

### Terminal

A persistent multi-panel terminal lives inside the editor, managed by [Termite](https://github.com/ruicsh/termite.nvim). Spin up as many terminal panels as you need, cycle through them, maximize one to full screen, and jump back to the editor — all without touching the mouse. The Moodle commands open their own terminal split automatically, so running a test suite or purging caches is a single command.

### Moodle Developer Workflows

The `:Moodle*` commands turn the most repetitive parts of a Moodle development cycle into one-liners:

- Run the test file you are editing right now
- Run all tests under a path or a full component test suite
- Purge caches, run the upgrade script, trigger cron
- Recompile JS for the current plugin with [Grunt](https://gruntjs.com) (Moodle's JS build tool)
- Drop into a [PsySH](https://psysh.org) REPL (an interactive PHP shell) to experiment with Moodle APIs live
- Open a full Claude Code session in a dedicated tab

### Snippets

Snippets are short templates that expand into boilerplate code as you type. Powered by [LuaSnip](https://github.com/L3MON4D3/LuaSnip), a flexible Neovim snippet engine, the library covers common PHP, JavaScript, and HTML patterns out of the box. A dedicated Moodle pack adds renderer methods, form elements, database API calls, capability checks, and more. Add your own snippets to `lua/config/snippets/` and they load automatically.

### Structural Code Selection

[Treesitter](https://tree-sitter.github.io/tree-sitter/) is a fast, accurate parser that builds a real syntax tree of your code. MoodleVim uses it for rich syntax highlighting across PHP, Lua, JavaScript, TypeScript, HTML, Bash, and Markdown — and also for smart selection. In visual mode, expand or shrink the selection one syntax node at a time — grab the current expression, grow it to the enclosing statement, keep going to the full function. A sticky context header always shows which class or function you are scrolled inside.

### AI Assistance

Bring any CLI-based AI coding agent — [Claude Code](https://claude.ai/code), Gemini CLI, Codex, or others — into the editor as a side panel via [Sidekick](https://github.com/folke/sidekick.nvim). Toggle the panel with `<leader>at`, send the current file or a visual selection to the agent's context, and accept or deny inline diffs from Claude with `<leader>aa` / `<leader>ad`. For bigger tasks, `:MoodleCodingAgent` opens a full-tab Claude Code session.

### Keymap Discovery

**This is the recommended way to explore the config.** You do not need to memorise anything upfront.

Every feature in MoodleVim is reachable through `<leader>` (Space). Press it and a popup appears showing all available keys grouped by category, each with a colour-coded icon and a plain-English description. Keep pressing to go deeper — the popup updates at every level.

| What you press | What you see |
|----------------|--------------|
| `<Space>` | All top-level groups: Files, Git, Search, Debug, AI… |
| `<Space>f` | All file-related actions |
| `<Space>G` | All git actions, split into worktree / index / merge subgroups |
| `<Space>d` | Diagnostics and debugger controls |

Press `<leader>?` at any time to open a full searchable list of every keymap in the config — useful when you know roughly what you want but not the exact key.

---

## Plugins

All plugins listed here are independent open source projects. MoodleVim only configures them — it does not maintain them. If you run into a bug or want a feature that is specific to a plugin's behaviour (not to how it is configured here), please refer to that plugin's own repository and documentation.

<details>
<summary>Full plugin list</summary>

| Plugin | Role |
|--------|------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager — loads plugins on demand to keep startup fast |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Shows available keymaps as you type a prefix — **the primary way to discover this config** |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | All-in-one utility: file/grep picker, notifications, scratch buffers, word navigation |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder used for LSP pickers, keymaps, help tags, and custom pickers |
| [harpoon](https://github.com/ThePrimeagen/harpoon) (v2) | Pin up to 4 buffers for instant switching |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Full Git integration: diffs, staging, merge tool, blame |
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | Collection of small focused plugins: file manager, diff signs, indent guides, auto-pairs |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol client — connects Neovim to debuggers like Xdebug |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | Classic split-panel debug UI (variables, call stack, watches) |
| [nvim-dap-view](https://github.com/igorlfs/nvim-dap-view) | Compact winbar debug UI with inline controls |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Fast, modern completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine with tabstop navigation |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Large VSCode-format snippet collection for PHP, JS, HTML, and more |
| [vscode-moodle-snippets](https://github.com/ManuelGil/vscode-moodle-snippets) | Moodle-specific snippet pack |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Accurate syntax parsing for highlighting, indent, and selection |
| [nvim-treeclimber](https://github.com/dkendal/nvim-treeclimber) | Expand/shrink selections by syntax tree node |
| [treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | Sticky header showing the current function or class as you scroll |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | Edit the filesystem like a buffer — rename, move, delete files with normal Vim commands |
| [termite.nvim](https://github.com/ruicsh/termite.nvim) | Persistent multi-panel terminal manager |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Runs formatters on save |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Runs linters as you edit |
| [sidekick.nvim](https://github.com/folke/sidekick.nvim) | Side-panel integration for CLI AI agents |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Installs and manages LSP servers, linters, and formatters |
| [mason-nvim-dap](https://github.com/jay-babu/mason-nvim-dap.nvim) | Installs DAP debug adapters via Mason |
| [tabby.nvim](https://github.com/nanozuki/tabby.nvim) | Tabline showing open tabs and buffers |
| [lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim) | Shows function signature hints as you type arguments |

</details>

---

## LSP & Tooling

A Language Server (LSP) is a background process that gives the editor deep understanding of your code — completions, definitions, errors, and more. Two PHP language servers run simultaneously with complementary capabilities:

| Server | Provides |
|--------|----------|
| [**Intelephense**](https://intelephense.com) | Completions, go-to-definition, references, symbols, hover, rename, code lens |
| [**PHPActor**](https://phpactor.readthedocs.io) | Code actions only (extract method, introduce variable, etc.) |

**Formatting** is off by default. Enable with `:ConformToggle`.

| Condition | Formatter |
|-----------|-----------|
| Moodle project | `phpcbf` (Moodle Coding Style) |
| Other PHP project | `php-cs-fixer` (Symfony rules) |

**Linting** runs automatically as you edit. **PHPStan** is available on demand via `:PhpStan`.

---

## Commands

All commands are available from the Neovim command line (`:CommandName`). Optional arguments are shown in `[brackets]`.

### Terminal

| Command | Description |
|---------|-------------|
| `:TermOpen` | Open a terminal split |

### Formatting & Linting

| Command | Description |
|---------|-------------|
| `:ConformToggle` | Toggle format-on-save on/off |
| `:ConformInfo` | Show the active formatter for the current buffer |
| `:LintInfo` | Show active linters for the current filetype |

### PHP Static Analysis

| Command | Description |
|---------|-------------|
| `:PhpStan` | Run PHPStan on the current buffer and populate diagnostics |

### Treesitter Inspection

| Command | Description |
|---------|-------------|
| `:TCDiffThis` | Diff the syntax tree of two windows |
| `:TCShowControlFlow` | Highlight the control flow of the node under cursor |
| `:TCHighlightExternalDefinitions` | Highlight all external symbol definitions in the buffer |

### Moodle

| Command | Arguments | Description |
|---------|-----------|-------------|
| `:MoodlePsysh` | — | Launch the PsySH PHP REPL in a terminal |
| `:MoodleTestBuffer` | — | Run PHPUnit on the current file |
| `:MoodleTestPath` | `[path]` | Run PHPUnit on a path; prompts if omitted |
| `:MoodleTestSuite` | `[component]` | Run a component test suite; prompts if omitted |
| `:MoodlePurgeCaches` | — | Purge all Moodle caches |
| `:MoodleUpgrade` | — | Run the Moodle upgrade script non-interactively |
| `:MoodleCron` | — | Run all scheduled Moodle tasks |
| `:MoodleCompileJS` | — | Recompile JS for the current plugin with grunt |
| `:MoodleCodingAgent` | — | Open a Claude Code session in a dedicated tab |

---

## Keymaps

`<leader>` is **Space**.

### How keymap discovery works

**Press `<Space>` and follow the popup.** You do not need to memorise anything.

[which-key.nvim](https://github.com/folke/which-key.nvim) shows a popup after a short delay whenever you start a key sequence. Every group has an icon and a plain-English label. Keep pressing keys to go deeper — the popup updates at each level. Press `<Esc>` to cancel.

```
<Space>          → shows all groups: Find, Files, Search, Refactor, Debug, Git…
<Space>f         → shows all file actions: find, recent, by scope…
<Space>x         → shows all debug actions: breakpoints, step controls, UI…
```

Press `<leader>?` at any time to open a **full searchable list** of every keymap in the config — sorted by description, so you can find things by what they do rather than what key they're on.

### Groups at a glance

| Prefix | Group | What lives here |
|--------|-------|-----------------|
| `<leader>f` | Find | File finders scoped by project, plugin, config |
| `<leader>e` | Files | Oil and MiniFiles file managers |
| `<leader>g` | Grep | Text search scoped by project, plugin, config |
| `<leader>s` | Search (LSP) | Definitions, references, symbols, document/workspace search |
| `<leader>r` | Refactor | Rename symbol, rename file, code actions |
| `<leader>d` | Diagnostics | Project and file diagnostics, TODOs |
| `<leader>x` | Debug | Breakpoints, DAP UI and view controls |
| `<leader>w` | Working tree | Git diffs and changes for unstaged files |
| `<leader>i` | Index | Git diffs and changes for staged files |
| `<leader>m` | Merge | Git 3-way merge diff and conflict list |
| `<leader>n` | Navigation | Harpoon — pin and jump to up to 4 buffers |
| `<leader>q` | Quick pick | Buffers, keymaps, help, pickers, resume last |
| `<leader>t` | Testing | Test runners (PHPUnit via `:Moodle*` commands) |
| `<leader>.` | Scratch | Scratch buffers |
| `<leader>a` | Agentic coding | Sidekick AI panel, Claude context, diff accept/deny |

### Key reference

**Discovery**

| Key | Description |
|-----|-------------|
| `<leader>?` | Full searchable keymap list |
| `<leader>qb` | Open buffer list |
| `<leader>ql` | Resume last picker |
| `<leader>qk` | Browse all keymaps |
| `<leader>qh` | Search help tags |

**Files & search**

| Key | Description |
|-----|-------------|
| `<leader>ff` | Find files (project root) |
| `<leader>f.` | Find files (closest component root) |
| `<leader>fc` / `<leader>fp` | Find files (Neovim config / plugins) |
| `<leader>fr` | Recent files |
| `<leader>gg` | Grep (project root) |
| `<leader>g.` | Grep (closest component root) |
| `<leader>gw` | Grep word under cursor |
| `<leader>sl` | Search lines in current buffer |
| `<leader>eo` | Open Oil file manager |
| `<leader>em` | Open MiniFiles |

**Code intelligence (LSP)**

| Key | Description |
|-----|-------------|
| `<leader>sd` | Go to definition |
| `<leader>si` | Go to implementations |
| `<leader>sr` | Find references |
| `<leader>sb` | Document symbols |
| `<leader>sw` | Workspace symbols |
| `<leader>rs` | Rename symbol |
| `<leader>ra` | Code actions |
| `<leader>rf` | Rename file (LSP-aware) |
| `<leader>su` | Toggle symbol usage hints |

**Diagnostics**

| Key | Description |
|-----|-------------|
| `<leader>dc` | Project diagnostics → quickfix |
| `<leader>dl` | File diagnostics → loclist |
| `<leader>dt` | TODOs → quickfix |

**Git**

| Key | Description |
|-----|-------------|
| `<leader>wp` | Toggle inline diff overlay |
| `<leader>wd` | Worktree diff split |
| `<leader>wc` | Worktree changes → quickfix |
| `<leader>id` | Index (staged) diff split |
| `<leader>ic` | Index changes → quickfix |
| `<leader>md` | 3-way merge diff split |
| `<leader>mc` | Merge conflicts → quickfix |

**Navigation (Harpoon)**

| Key | Description |
|-----|-------------|
| `<leader>na` | Add current buffer |
| `<leader>nm` | Open navigation menu |
| `<leader>nh/nj/nk/nl` | Jump to pinned buffer 1/2/3/4 |

**Debug**

| Key | Description |
|-----|-------------|
| `<F5>` | Start / continue |
| `<F6>` | Step over |
| `<F7>` | Step into |
| `<F8>` | Step out |
| `<F9>` | Run to cursor |
| `<F10>` | Terminate |
| `<leader>xb` | Toggle breakpoint |
| `<leader>xl` | Toggle logpoint |
| `<leader>xuo` / `<leader>xuc` | Open / close debug UI |
| `<leader>xvo` / `<leader>xvc` | Open / close debug view |

**AI (Agentic coding)**

| Key | Description |
|-----|-------------|
| `<leader>at` | Toggle AI panel |
| `<leader>al` | List agents |
| `<leader>af` | Add file to context |
| `<leader>as` | Add selection to context (visual) |
| `<leader>aa` / `<leader>ad` | Accept / deny diff |
| `<leader>ap` | Prompt template |
| `<leader>aq` | Detach session |
| `<C-s>` | Toggle focus to AI panel |

**Global keys**

| Key | Mode | Description |
|-----|------|-------------|
| `<C-h/j/k/l>` | n | First/next/prev/last in active quickfix or loclist |
| `<C-f>` / `<C-b>` | n | Next/prev reference of word under cursor |
| `<C-p>` | n | Jump to parent scope (treesitter context) |
| `<C-\>` | n/t | Toggle terminal panel |
| `<C-s>` | n/t/i/x | Toggle AI panel focus |

**Treesitter node selection** (visual / operator-pending mode)

| Key | Description |
|-----|-------------|
| `<C-h>` | Select parent node |
| `<C-j>` / `<C-k>` | Select next / previous sibling |
| `<C-l>` | Select child node (shrink) |
| `J` / `K` | Grow selection forward / backward |
| `I` / `A` | Select inner / around node |

---

## Configuration

Key globals in `lua/config/options.lua`:

| Variable | Default | Description |
|----------|---------|-------------|
| `vim.g.default_colorscheme` | `tokyonight` | Active theme. Options: `solarized`, `tokyonight`, `gruvbox-material`, `everforest` |
| `vim.g.have_nerd_font` | `true` | Set `false` to disable icon rendering |
| `vim.g.formatters_enabled` | `false` | Format-on-save; toggle with `:ConformToggle` |
| `vim.g.plugins_dev_path` | `~/repos/nvim-plugins/` | Base path for local plugin development |

---

## Roadmap

This section tracks planned improvements. Items are drawn from the project backlog and open issues. Contributions towards any of these are very welcome — see [Contributing](#contributing).

### In Progress

_Nothing actively in progress right now._

### Planned

- [ ] **Resolve `<C-h/j/k/l>` keymap conflicts** — these keys are shared across quickfix navigation, completion, and treesitter selection. A dedicated layer or alternative bindings will eliminate the ambiguity.
- [ ] **Lua step debugging** — add the `osv` DAP adapter so Lua plugin code can be debugged live inside a running Neovim instance.
- [ ] **Neovim plugin test runner** — integrate `neotest` with `neotest-plenary` for structured test output when developing Lua plugins.
- [ ] **Lua plugin snippets** — a curated set of LuaSnip snippets for common Neovim plugin patterns (`vim.keymap.set`, `vim.api.nvim_create_autocmd`, module boilerplate, etc.).
- [ ] **`.luarc.json` starter template** — a ready-to-use template for new Neovim plugin projects that configures lua-language-server with the correct globals and library paths.

### Under Consideration

- [ ] **Moodle component discovery** — index available Moodle components so `:MoodleTestSuite` can offer tab-completion on real component names.
- [ ] **Neotest PHPUnit integration** — replace the current terminal-based test commands with a proper neotest adapter for inline test results and re-run on save.
- [ ] **Database UI** — surface the existing `vim-dadbod` completion integration with a full UI for exploring and querying the Moodle database directly from the editor.

---

## Contributing

Contributions are welcome! Here is how to get involved:

**Reporting a bug**

Before opening an issue, check whether the problem comes from this config or from one of the bundled tools. A good way to tell: if disabling a plugin in `lua/plugins/` makes the problem go away, it is likely a configuration issue and belongs here. If the problem persists regardless of this config, report it to the relevant plugin or tool directly — links to every project are in the [Plugins](#plugins) section.

If the bug is in this config, open an issue and include:
- `nvim --version` output
- OS, PHP version, and whether you are in a Moodle project or a generic PHP project
- Steps to reproduce and any relevant error messages

**Requesting a feature**

Open an issue describing the workflow you want to improve. If it is Moodle-specific or benefits the PHP development experience, it is a good fit.

**Submitting a pull request**

1. Fork the repository and create a branch from `devdist`
2. Make your changes
3. Open a pull request against `devdist` with a clear description of what changed and why

Please keep pull requests focused — one feature or fix per PR makes review much easier.
