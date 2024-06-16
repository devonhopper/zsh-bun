#!/usr/bin/env zsh
# shellcheck disable=SC1090

# Exit if the 'bun' commabund can not be found
if ! (( $+commands[bun] )); then
    echo "WARNING: 'gh' command not found"
    return
fi

# Completions directory for `bun` commands
local COMPLETIONS_DIR="${0:A:h}/completions"

# Add completions to the FPATH
typeset -TUx FPATH fpath
fpath=("$COMPLETIONS_DIR" $fpath)

# If the completion file does not exist yet, then we need to autoload
# and bind it to `bun`. Otherwise, compinit will have already done that.
if [[ ! -f "$COMPLETIONS_DIR/_bun" ]]; then
    typeset -g -A _comps
    autoload -Uz _bun
    _comps[bun]=_bun
fi

# Generate and load completion in the background
bun completions zsh >| "$COMPLETIONS_DIR/_bun" &|
