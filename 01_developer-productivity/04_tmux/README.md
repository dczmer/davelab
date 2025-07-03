# Developer Productivity 04 - `tmux`


https://github.com/tmux/tmux/wiki
https://github.com/tmux/tmux/wiki/Installing
https://tmuxreference.com/
https://github.com/tmux/tmux/wiki/Getting-Started
`man tmux`

TODO: exercises

## What is `tmux`?


## Installing

Install with your package manager (`homebrew`, `dnf`, `pacman`, etc.).

If you have any issues, there is an [Installation Guide](https://github.com/tmux/tmux/wiki/Installing).

## Sessions

## Panes and Windows

- prefix

## Configuring

[Example tmux.conf](./tmux.conf)

You can copy the provided configuration file to `~.tmux.conf` or `~/.config/tmux/tmux.conf` and use it directly. It's a pretty standard configuration and it's short enough that we can walk through the whole thing, and you can change it to your taste.

The first customization I always make is to re-bind the `prefix` key. By default, it's `C-b` (Ctrl+b). That's kind of awkward to type, and feels like it's probably bad for your wrist.

You may like to re-bind the `prefix` to something like `C-a` or even "\`" (back-tick).

```tmux
unbind C-b
set -g prefix C-a
bind C-a send-prefix
```

Using `C-a` is a little more comfortable, doesn't typically conflict with other common keybindings, and matches the `prefix` idiom used by `gnu-screen`.

The idea behind using "\`" was that it was a single-key prefix, which makes it easy to type, and it's rarely typed in day-to-day work. If you do need to use it, you can hit "\`" twice in a row. However, I find myself writing a lot more `markdown` with code sections, or other applications where I actually need to use "\`". So I typically use `C-a` myself.

I also like to bind a key to `source` the configuration file to apply recent changes:

```tmux
unbind r
bind r source-file ~/.config/tmux/tmux.conf
```

I disable support for mouse selection and input, set the clock to 24-hour format, and set a large history limit. You may want to customize these:

```tmux
set  -g mouse             off
setw -g clock-mode-style  24
set  -g history-limit     50000

```

### Status Line

The `tmux` status-line shows a list of active windows in your session, and indicates which one is selected.

It can also be configured to show useful information,

TODO: screen-shot

```tmux
set -g status-style bg='#111111',fg='#676E7D'
set -g status-interval 1
set -g status-left '[#{session_name}] '
set -g status-right '%Y-%m-%d %T %A'
set-option -g status-position bottom
```

#### Format String

- the string is first run through `strftime` (`man 3 strftime`), then processed for `format variables`
- format variables are enclosed in `#{ ... }`
    - some variables have shorter 'alias' tags, like `#S`
    - escape literal `#` with `##`
    - supports conditionals `#{?VAR,TRUE,FALSE}`
        - `#{?session_attached,attached,not attached}`
    - string comparisons can be expressed as `#{==:VAR1,VAR2}`, etc.
    - regex match expression `#{m:PATTERN,VAR}`
    - limit the length of the resulting string `#{=5:pane_titile}`. negative numbers count from the end of the string.
    - prefixing a epoch value with `:t` (`#{t:VAR}`) will format it as a localize date time string
    - `:b` and `:d` prefixes will print basename and dirname of a variable with a file name
    - `:q` will shell escape characters
    - `:E` and `:T` will expand the format twice, so if you have a format string in another variable. `:T` is for times, like `:t`.
    - `S:`, `W:`, `P:` or `L:` will loop over every session, window, or pane and insert the format once for each hit.
    - `N:` checks if a window or session name exists
    - substitution prefix: `s/foo/bar/:` will replace the substring in the var/expression
    - the last line of the shell command's output `#()`. for example `#(hostname)` or `#(uptime)`
    - `:l` specifies that the string should be treated literally and not expanded
- format styles are enclosed in `#[ ... ]`
    - use the single term `default` to reset styles (`status-style`)
    -

https://github.com/jimeh/tmux-themepack

## Important Keybindings

## Commands

## `tmux-send-keys`

## Plugins and Alternatives


