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

a stupid simple way to quickly create a sandbox for anything for rapid prototyping written in zsh.

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
export SBOX_DIR="$HOME/code/sandboxes/"
```

## Usage

`sbox`
: asks for template via fzf, asks for a name, and creates the sandbox.

`sbox ./something`
: set the target directory to `./something` relative to the current working
: directory, then creates the sandbox.

`sbox something`
: shows template selection and sets target directory to `something` in the 
: sandbox folder, then creates the sandbox.

### sbox hooks

There are two hooks:

`setup`
: will be run right after creation, but in the context wherever you ran `sbox`.
: so this is the best place to run any kind of prompt etc.

`launch`
: when everything is done, this hook will be called. This can be used to set up
: tmux windows and start processes etc. You could also start GUI editors in here like `zed`

```sh
# .sboxrc
setup () {
    pnpm install --prefer-offline
}

launch () {

}
```

### General Tips

Some tips from using and refining this workflow for about a year now:

#### stick to a naming pattern

Use the naming pattern `[context]--[name]`, where context usually is the language or framework and use name to very briefly describe what youre trying out.
This will make it easier to find and re-use previous sandboxes.


#### use .sboxrc

make use of the .sboxrc to setup and launch servers and open browsers.

```
launch() {
    tmux neww
    tmux send-keys nvim Enter
    tmux neww 
    tmux send-keys pnpm run dev Enter
    open http://localhost:3000
    zed .
}
```

```
launch() {
    tmux neww 
    tmux send-keys devenv up
    open http://localhost:4000
}
```






## Description

Fundamentally `sbox` glues a handful of unix tools together.
It launches fzf to choose a template.

All in all the entire script is under 200 lines.

It uses rsync to copy files from the template to the source. This way it's easy
to define files to exclude and things are blazingly fast, and it's not necessary
to run `pnpm install` or whatever if the template had everything set up.

## why zsh?

I wanted to understand zsh better, and also have my own little "reference". 
This was just a good opportunity.

Also this way it was easy to rely on existing tooling and keep the entire thing
at a fairly low amount of lines.

