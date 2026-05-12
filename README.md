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

---

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
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

Bring any CLI-based AI coding agent — [Claude Code](https://claude.ai/code), Gemini CLI, Codex, or others — into the editor as a side panel via [Sidekick](https://github.com/folke/sidekick.nvim). Send the current file, a visual selection, or the syntax node under the cursor to the agent with a single key. Edit suggestions from the agent appear inline and can be accepted with `<tab>`. For bigger tasks, `:MoodleCodingAgent` opens a full-tab Claude Code session.

### Keymap Discovery

Never memorise a keymap again. Press any prefix and a popup shows every available continuation with its description. Press `<leader>?` to open a searchable reference of every keymap in the config.

---

## Plugins

<details>
<summary>Full plugin list</summary>

| Plugin | Role |
|--------|------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager — loads plugins on demand to keep startup fast |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Shows available keymaps as you type a prefix |
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

Press `<leader>?` at any time to open a searchable keymap reference powered by which-key.

### General

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>?` | n | Show all keymaps (which-key) |
| `<leader>sf` | n | Source the current Lua file |
| `<Esc>` | n | Clear search highlight |
| `<leader>oo` | n | Close all other windows |

### Quickfix & Location Lists

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>co` | n | Open quickfix list |
| `<leader>cc` | n | Close quickfix list |
| `<leader>lo` | n | Open location list |
| `<leader>lc` | n | Close location list |
| `<C-h>` | n | First entry in active list |
| `<C-j>` | n | Next entry in active list |
| `<C-k>` | n | Previous entry in active list |
| `<C-l>` | n | Last entry in active list |

> `<C-h/j/k/l>` act on the location list when it is open, otherwise the quickfix list. Note these keys overlap with completion navigation (`<C-j>/<C-k>`) and treesitter selection (`<C-h/j/k/l>` in visual/operator mode) — a remapping is planned, see [Roadmap](#roadmap).

### Diagnostics & TODOs

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>dc` | n | Send diagnostics to quickfix list |
| `<leader>dl` | n | Send diagnostics to location list |
| `<leader>td` | n | Open TODO comments in quickfix list |

### Files

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>e` | n | Open Oil file manager (floating) |
| `<leader>fm` | n | Open MiniFiles at current buffer's directory |
| `<leader>ff` | n | Find files (project root) |
| `<leader>f.` | n | Find files (closest plugin/component root) |
| `<leader>fc` | n | Find files (Neovim config) |
| `<leader>fp` | n | Find files (plugins directory) |
| `<leader>fl` | n | Recent files |

### Grep

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gg` | n | Grep (project root) |
| `<leader>g.` | n | Grep (closest root) |
| `<leader>gc` | n | Grep (Neovim config) |
| `<leader>gp` | n | Grep (plugins directory) |
| `<leader>gw` | n | Grep word under cursor |
| `<leader><leader>` | n | Fuzzy search lines in current buffer |

### Telescope

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ss` | n | Open Telescope builtin picker |
| `<leader>kk` | n | Browse all keymaps |
| `<leader>ll` | n | Resume last Telescope picker |
| `<leader>pp` | n | Browse recent pickers |
| `<leader>hh` | n | Search help tags |
| `<leader>bb` | n | Browse open buffers |
| `<leader>ip` | n | Inspect installed plugins |
| `<leader>jj` | n | Jump within current buffer |

### LSP

> Active only when a language server is attached to the buffer.

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sd` | n | Go to definition (split preview) |
| `<leader>si` | n | Go to implementations |
| `<leader>sr` | n | Find all references |
| `<leader>rn` | n | Rename symbol |
| `<leader>ds` | n | Document symbols |
| `<leader>ws` | n | Workspace symbols |
| `<leader>ca` | n / v | Code actions |
| `<leader>rf` | n | Rename file (LSP-aware) |

### Git

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>Gp` | n | Toggle inline diff overlay |
| `<leader>Gwd` | n | Diff split: worktree vs HEAD |
| `<leader>Gid` | n | Diff split: index (staged) vs HEAD |
| `<leader>Gmd` | n | 3-way merge diff split |
| `<leader>Gwc` | n | Worktree changes → quickfix list |
| `<leader>Gwl` | n | Worktree changes → location list |
| `<leader>Gic` | n | Staged changes → quickfix list |
| `<leader>Gil` | n | Staged changes → location list |
| `<leader>Gmc` | n | Merge conflicts → quickfix list |
| `<leader>Gml` | n | Merge conflicts → location list |

### Harpoon

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ha` | n | Add current buffer to list |
| `<leader>hl` | n | Toggle Harpoon quick menu |
| `<leader>gh` | n | Jump to Harpoon buffer 1 |
| `<leader>gj` | n | Jump to Harpoon buffer 2 |
| `<leader>gk` | n | Jump to Harpoon buffer 3 |
| `<leader>gl` | n | Jump to Harpoon buffer 4 |

### Scratch Buffers

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>..` | n | Open scratch buffer |
| `<leader>.l` | n | List and select scratch buffers |

### Word Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<C-f>` | n | Jump to next reference of word under cursor |
| `<C-b>` | n | Jump to previous reference of word under cursor |

### Debugger (DAP + Xdebug)

| Key | Mode | Description |
|-----|------|-------------|
| `<F5>` | n | Continue / start debugging |
| `<F6>` | n | Step over |
| `<F7>` | n | Step into |
| `<F8>` | n | Step out |
| `<F9>` | n | Run to cursor |
| `<F10>` | n | Terminate session |
| `<leader>br` | n | Toggle breakpoint |
| `<leader>lp` | n | Toggle log point (prompts for message) |
| `<leader>duo` | n | Open dap-ui panels |
| `<leader>duc` | n | Close dap-ui panels |
| `<leader>dvo` | n | Open dap-view |
| `<leader>dvc` | n | Close dap-view |

### Terminal (Termite)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-\>` | n / t | Toggle terminal panel |
| `<C-t>` | t | Create new terminal |
| `<C-n>` | t | Focus next terminal |
| `<C-p>` | t | Focus previous terminal |
| `<C-e>` | t | Return focus to editor |
| `<C-[>` | t | Exit terminal insert mode |
| `<C-z>` | t | Maximize / restore terminal panel |
| `<leader><Esc>` | t | Stop insert mode |
| `q` | t (normal) | Close terminal window |

### AI / Sidekick

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>aa` | n | Toggle Sidekick CLI panel |
| `<leader>ac` | n | Toggle Claude via Sidekick |
| `<leader>as` | n | Select Sidekick CLI tool |
| `<leader>ad` | n | Detach CLI session |
| `<leader>at` | n / x | Send current node to CLI |
| `<leader>af` | n | Send current file to CLI |
| `<leader>av` | x | Send visual selection to CLI |
| `<leader>ap` | n / x | Select and run a Sidekick prompt |
| `<c-.>` | n / i / x / t | Focus Sidekick CLI panel |
| `<tab>` | n | Jump to / apply next edit suggestion |

### Treesitter Selection

> These keys apply in **visual** and **operator-pending** mode only.

| Key | Mode | Description |
|-----|------|-------------|
| `<C-h>` | x / o | Select parent node |
| `<C-j>` | x / o | Select next sibling node |
| `<C-k>` | x / o | Select previous sibling node |
| `<C-l>` | x / o | Select child node (shrink) |
| `J` | x / o | Grow selection forward |
| `K` | x / o | Grow selection backward |
| `I` | x / o | Select current node (inner) |
| `A` | x / o | Select parent node (around) |
| `{{` | n | Jump to context |

### Completion (insert mode)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-space>` | i | Trigger snippet completions |
| `<C-j>` | i | Select next item |
| `<C-k>` | i | Select previous item |
| `<C-l>` / `<C-CR>` / `<CR>` | i | Accept completion |
| `<C-f>` | i | Expand snippet / jump to next field |
| `<C-b>` | i | Jump to previous snippet field |

### Oil (inside file manager buffer)

| Key | Mode | Description |
|-----|------|-------------|
| `<CR>` or `l` | n | Open file / enter directory |
| `h` | n | Go to parent directory |
| `<Esc>` | n | Close Oil |

### MiniFiles (inside file manager buffer)

| Key | Mode | Description |
|-----|------|-------------|
| `<ESC>` | n | Close MiniFiles |
| `:w<CR>` | n | Apply filesystem changes |

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

Open an issue and include:
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
