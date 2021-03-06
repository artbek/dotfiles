export EDITOR=vim

export VIM_NOESCKEYS=1
export VIM_CHANGE_CURSOR_SHAPE=1

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=2000
export SAVEHIST=2000
setopt appendhistory

setopt PROMPT_SUBST
export PROMPT='%F{154}[$(pwd)]%F{244}[%?]%f ' # GREEN
export PROMPT='%F{214}[$(pwd | perl -pe "s#.+(/[^/]+/[^/]+/[^/]+$)#...\1#")]%F{58}[%?]%f ' # ORANGE

bindkey -e

plugins=(... zsh-completions)
autoload -U compinit && compinit

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

bindkey "^U" backward-kill-line
bindkey "^ " expand-or-complete

up-directory() {
	builtin cd .. && zle reset-prompt
}
zle -N up-directory
bindkey "^[h" up-directory

### ALIASES

alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'
alias erc="$EDITOR $HOME/.zshrc"
alias rrc="source $HOME/.zshrc"

source $HOME/.zsh_aliases


### FUNCTIONS

source $HOME/.zsh_functions
