#
# Allow managing PATH vars as zsh arrays:
#
# Some standard environment variables are just a single string, delimited by
# ":" between entries (PATH="/bin:/usr/bin:/usr/share/bin").
# With these variables, you can manipulate the vars like arrays of paths, and
# the entries will automatically update the corresponding environment variable.
# Managing the paths this way will also make sure the list does not contain
# any duplicate entries.
typeset -U path cdpath fpath manpath


#
# Command history settings:
#
# Set a specific location for your history file.
# This is required if you want to share history between terminals.
HISTFILE="$HOME/.zsh_history"
# Max number of history events to save in the file.
HISTSIZE="50000"
# Max number of history events to save in memory in your active session.
SAVEHIST="50000"
# Shares history between all terminals by having them load-in and append their
# session histories to the history file.
setopt SHARE_HISTORY
setopt APPEND_HISTORY
# Use the OS file locking implementation for the shared history file.
setopt HIST_FCNTL_LOCK
# Do not add a command to the list if it is a duplicate of the previous one.
# But do allow duplicate commands in the history (just not consecutive ones).
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
# Allow saving and finding/searching through duplicate entries in the history.
# I like to keep these enabled because I often use the history to replay a
# repeated sequence of commands and they need to be complete and ordered.
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
# If the command starts with a " ", don't add it to the history file.
setopt HIST_IGNORE_SPACE
# Don't expire duplicate entries earlier; just delete by age alone.
unsetopt HIST_EXPIRE_DUPS_FIRST
# EXTENDED_HISTORY saves the beginning timestamp and duration with every entry.
setopt EXTENDED_HISTORY


#
# Custom variables:
#
# `export` some common variables into the shell environment.
export EDITOR='vim'
# This makes sorting work like in programming:
# all uppercase letters sort before lowercase letters, like the ASCII table.
export LC_COLLATE=C
# Add a custom PATH location for custom scripts.
# When you type a command at the shell, it will look through these paths to
# find the matching file. You do not need to use the full path to the scripts
# in these paths.
export PATH="$PATH:~/bin"
# If we didn't use the `typeset` command, at the top of the file, you would
# manage your PATH like this instead:
# `export PATH="$PATH:~/bin"`


#
# Custom aliases:
#
# Define some aliases. Short-cuts for commonly used commands.
alias -- ls='ls --color'
alias -- la='ls -al'
alias -- ll='ls -l'


#
# Custom keybindings:
#
# The ZSH line editor lets you open a text editor with the current content from
# your prompt, edit it, then write it out to put it back on the terminal.
#
# If use vim keybindings for the line editor:
#   bindkey -v
#
# automatically find the location of the edit-command-line function from $fpath.
autoload edit-command-line
zle -N edit-command-line
# bind ctrl+z to start the line editor.
bindkey "^z" edit-command-line
# Other keybindings:
# Ctrl+shift+K will instantly erase your entire command so you can start over.
bindkey "^K" kill-whole-line
# Ctrl+shift+R will reverse the direction of Ctrl+R incremental history search.
bindkey "^R" history-incremental-search-backward
# Bind home + end to navigate to front and end of line.
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line


#
# Making a modular configuration:
#
# Source other shell scripts to make a modular configuration layout,
# using either `. /path/to/file.zsh` or `source /path/to/file.zsh`.
