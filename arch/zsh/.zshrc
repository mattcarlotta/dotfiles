typeset -U path

# Set up the prompt
#
source ~/custom-fns.zsh
source ~/alias.zsh
# source $HOME/.cargo/env
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

setopt PROMPT_SUBST
autoload -Uz promptinit
promptinit
# prompt adam1
PROMPT='$(check_git_status)'

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTFILESIZE=10000
HISTSIZE=5000
SAVEHIST=2000
export HISTFILE=~/.zsh_history
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=/opt/homebrew/bin/nvim
export BUN_INSTALL=$HOME/.bun
path+=("$BUN_INSTALL/bin" "/opt/homebrew/opt/sqlite/bin" "$HOME/.local/bin")
export TERM=xterm-256color
eval "$(/opt/homebrew/bin/brew shellenv)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh


# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit
