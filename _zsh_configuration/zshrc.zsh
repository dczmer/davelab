# Allow managing PATH vars as zsh arrays:
typeset -U path cdpath fpath manpath

# Command history settings:
HISTFILE="$HOME/.zsh_history"
HISTSIZE="50000"
SAVEHIST="50000"
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

# GIT/VCS Prompt Support
autoload -Uz vcs_info
setopt prompt_subst
precmd() {
    vcs_info
}
zstyle ':vcs_info:*' formats '%s(%F{red}%b%f)'
zstyle ':vcs_info:git:*' formats '%F{green} %f(%b)%F{yellow}%u%c%f'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr " "
zstyle ':vcs_info:git:*' unstagedstr " "
zstyle ':vcs_info:git:*' actionformats '%F{green} %f(%F{yellow}%b%f|%F{red}%a%f)'

export PS1='${vcs_info_msg_0_} %F{blue} %f%1d%1(j. %F{yellow}%j%f.)%F{blue}>%f '
export RPROMPT='<%0(?..%F{red}%?%f)%F{blue}%t%f'

# Auto-complete engine:
autoload -Uz compinit bashcompinit
compinit
bashcompinit
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' menu select search
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' squeeze-slashes true
unsetopt MENU_COMPLETE

# Custom keybindings:

# To use vim keybindings for the line editor:
#  bindkey -v
autoload edit-command-line
zle -N edit-command-line
bindkey "^z" edit-command-line
bindkey "^K" kill-whole-line
bindkey "^R" history-incremental-search-backward
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

# Custom variables:

export EDITOR='vim'
# This makes sorting work like in programming:
# all uppercase letters sort before lowercase letters, like the ASCII table.
export LC_COLLATE=C
# Add a custom PATH location for custom scripts.
export path=($path "~/bin")

# Custom aliases:

alias -- ls='ls --color'
