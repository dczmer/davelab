#
# Auto-complete engine:
#
# Initialize auto-completion engine.
# Find the method `compinit` in `$fpath` at runtime, then invoke it.
# Use <tab> to see completion options for the command you are typing.
# And `bashcompinit` allows zsh to use completion functions written for bash.
autoload -Uz compinit bashcompinit
compinit
bashcompinit
#
# NOTE: using zstyle to configure and customize the completion engine here
# is out of scope for this simple walk-through.
# These lines will unlock some hidden features of the completion menu, but
# they are optional and not required for the completion menu to work.
# https://thevaluable.dev/zsh-completion-guide-examples/
#
zstyle ':completion:*' completer _extensions _complete _approximate
# allow caching the completion matches
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
# when you hit <TAB> twice, show a menu with all the options and allow fuzzy
# searching through the results.
# use <TAB> to cycle through the results or use the search.
zstyle ':completion:*' menu select search
# use a custom format for displaying the completion menu.
# display a green line with the description text of the current match.
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
# custom format for displaying messages and warnings from the completion system.
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
# allow grouping of completion options.
zstyle ':completion:*' group-name ''
# makes the completion list use colors from LS_COLORS.
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
# change how `//` is expanded by the completion system.
zstyle ':completion:*' squeeze-slashes true
# the first time you hit <tab> it will show the menu, but not select anything.
# if you press <tab> again, then you focus the menu. press <tab> to cycle
# through the menu items and enter/return to select.
unsetopt MENU_COMPLETE
