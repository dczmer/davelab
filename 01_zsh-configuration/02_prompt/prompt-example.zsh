#===============================================================================
#===============================================================================
# GIT/VCS Prompt Support
#
# Use the `vcs_info` system of zsh to get some basic info about the current git
# repository, so we can include it in our custom shell.
#===============================================================================
#===============================================================================
#
# load vsc_info, which lets zsh gather info about your version-controlled data.
autoload -Uz vcs_info
# this will run before each time the prompt is rendered.
# it creates a new variable called `vcs_info_msg_0` with info about the current
# system.
precmd() {
    vcs_info
}
#
#
# Some example 'git' vcs_info formats.
# I won't explain `zstyle`, but will give enough context for you to copy, and
# use, and customize these, if you want a `git` status section in your prompt.
#
#
# Very simple: `git(branch-name)`:
# - `%s` is the VCS system, presumably 'git'.
# - `%b` is the branch name (printed in red).
# This would apply to any VCS, but we're only going to focus on `git` from here
# out.
zstyle ':vcs_info:*' formats '%s(%F{red}%b%f)'
#
# Similar to above, but with an icon for `git`, instead of text.
# It also shows two icons at the end, one to indicate you have pending
# 'unstaged' changes, and one that shows if you have 'unstaged' changes.
zstyle ':vcs_info:git:*' formats '%F{green} %f(%b)%F{yellow}%u%c%f'
#
# if you set this, then it will check for pending changes in your directory.
# this will populate the `%c` and `%u` (staged and unstaged) variables from the
# `formats` style above.
zstyle ':vcs_info:git:*' check-for-changes true
# by default, the unstaged (`%u`) format prints 'U', and the staged (`%c`)
# prints a 'C'. but you can override them, if you want:
zstyle ':vcs_info:git:*' stagedstr " "
zstyle ':vcs_info:git:*' unstagedstr " "
#
# When you are doing an action, like a merge or rebase, show the same prompt
# as above, but the branch name is yellow and the current 'action' is printed
# in red.
zstyle ':vcs_info:git:*' actionformats '%F{green} %f(%F{yellow}%b%f|%F{red}%a%f)'
#===============================================================================
#===============================================================================

# you need this to make the prompt string work correctly with vcs_info.
# this enables your PS1 and other prompt strings to interpolate certain values
# into the string, even when the string is using single-quotes, which don't
# usually allow interpolation.
setopt prompt_subst

# This is a simple prompt, that I like:
# - our custom vcs_info string, from above
# - a blue 'folder' icon
# - `%1d` prints the current directory name (not the parents/path)
# - `%?` shows the status code of the previously run command
export PS1='${vcs_info_msg_0_} %F{blue} %f%1d %?%F{blue}>%f '
# NOTE that the use of single-quotes + the `prompt_subst` thing above are
# required to make the vcs_info part update every time the prompt is shown.
