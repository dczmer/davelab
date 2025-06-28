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
precmd() {
    vcs_info
}
zstyle ':vcs_info:*' formats '%s(%F{red}%b%f)'
zstyle ':vcs_info:git:*' formats '%F{green} %f(%b)%F{yellow}%u%c%f'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr " "
zstyle ':vcs_info:git:*' unstagedstr " "
zstyle ':vcs_info:git:*' actionformats '%F{green} %f(%F{yellow}%b%f|%F{red}%a%f)'
setopt prompt_subst

export PS1='${vcs_info_msg_0_} %F{blue} %f%1d %?%F{blue}>%f '

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

# use vim keybindings for the line editor.
#bindkey -v
# automatically find the location of the edit-command-line function from $fpath.
autoload edit-command-line
zle -N edit-command-line
# bind ctrl+e to start the line editor.
bindkey "^e" edit-command-line
# Other keybindings:
# Ctrl+shift+K will instantly erase your entire command so you can start over.
bindkey "^K" kill-whole-line
# Ctrl+shift+R will reverse the direction of Ctrl+R incremental history search.
bindkey "^R" history-incremental-search-backward
# Bind home + end to navigate to front and end of line.
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
