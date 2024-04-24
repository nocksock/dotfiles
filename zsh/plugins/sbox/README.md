```
         d8b
         ?88
          88b
 .d888b,  888888b  d8888b ?88,  88P
 ?8b,     88P `?8bd8P' ?88 `?8bd8P'
   `?8b  d88,  d8888b  d88 d8P?8b,
`?888P' d88'`?88P'`?8888P'd8P' `?8b

```

# sbox

a stupid simple way to quickly create local sandboxes from templates written in zsh.

## Installation

This plugin follows the zsh plugin community standard.
So it should work with any of the many plugin managers out there, but here are a few examples:

```
zgenom load nocksock/sbox
```

## Setup

Configure `sbox` via environment variables in your `~/.zshrc`.

```sh
# ~/.zshrc

# Required: Where to put your sandboxes
export SBOX_DEFAULT_START_DIR_PARENT="$HOME/code/sandboxes/"

# Optional: Where your templates are located.
#   default: $SBOX_DEFAULT_START_DIR_PARENT
export SBOX_TEMPLATE_DIR="$HOME/code/templates/"

# Optional How to start/open.
#   default: "tmux"
export SBOX_DEFAULT_LAUNCHER="tmux"
```

## Usage

```
sbox
```

## why zsh?

I wanted to understand zsh better, and alaso have my own little "reference". 
This was just a good opportunity.

