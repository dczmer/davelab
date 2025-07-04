# Developer Productivity 04 - `tmux`

## Objective

In this module, you will learn how to use `tmux` to manage multiple terminals, and how to reattach to a session if you accidentally close your window.

There is a lot more to `tmux` than these two topics, but these are the most basic features that you will need to start leveraging terminal multiplexing.

## Overview

Don't struggle with juggling multiple terminal windows, manage them with layouts so you can view them side-by-side, in a grid, or jump between the with a key press.

All of the terminals that you open in your layout will be saved to the active `session`. If you close your terminal window (or if you disconnect from a remote host using `tmux`), then you can re-attach to that `tmux` session and pick up exactly where you left off.

TODO: screen shot

From the `tmux` manual pages:

> tmux is a terminal multiplexer: it enables a number of terminals
> to be created, accessed, and controlled from a single screen.
> tmux may be detached from a screen and continue running in the
> background, then later reattached.

Terms:

- `prefix`
- `Pseudo terminal`
- `Terminal multiplexer` - Manages multiple 'pseudo terminals' inside of one terminal window/tab.
- `Session` - A single collection of terminals under management of `tmux`.
- `Window` - The visible 'screen' showing an arrangement of one or more terminals. A window can be split into multiple `panes`, and manages arrangement of those `panes`.
- `Pane` - One terminal instance. A `pane` can be arranged in a `window` or moved to other `windows` on the same `session`.

References:

- `man tmux`
- https://github.com/tmux/tmux/wiki
- https://github.com/tmux/tmux/wiki/Installing
- https://github.com/tmux/tmux/wiki/Getting-Started
- https://tmuxreference.com/

TODO: exercises

## Exploring the Examples

TODO

- Enter command or setting directly with `prefix+:`
- Update conf file and `source` with command `source-file ~/.config/tmux/tmux.conf`
    - bind to `prefix+r` for convenience

## Installing

Install with your package manager (`homebrew`, `dnf`, `pacman`, etc.).

If you have any issues, there is an [Installation Guide](https://github.com/tmux/tmux/wiki/Installing).

## Sessions, Windows, Panes

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

It can also be configured to show useful information about your command, session, or system environment.

TODO: screen-shot

```tmux
set -g status-style bg='#111111',fg='#676E7D'
set -g status-interval 1
set -g status-left '[#{session_name}] '
set -g status-right '%Y-%m-%d %T %A'
set-option -g status-position bottom
```

#### Format String

If you've ever configured a prompt-string for your shell, then you know how this works. Of course, `tmux` has it's own system and syntax, different from that of `zsh`. But, just like configuring your `zsh` prompt, you probably only need to do it one time, and it's not actually very hard.

You still supply a format-string, and certain characters and escape sequences will be replaced when the status line is rendered.

[Reference manual](https://www.man7.org/linux/man-pages/man1/tmux.1.html#FORMATS)

- Format variables are enclosed in `#{ ... }`. Example: `#{session_name}` would be replaced with the name of the current session.
- There is a ternary operator `${?VAR,TRUE,FALSE}`. Example: `#{?window_zoomed_flag,🔍,}` would show a magnifying glass icon if `zoom mode` is active, or nothing otherwise.
- Shell commands can be included in `#( ... )`. Example: `#(uptime)` would run the `uptime` command and render the output.
- Style sections of the status line with `#[STYLES]`. Example: `#[fg=FFFFFF bg=000000 bold]` would change the style to white foreground and black background, with bold text.
- Use the style `default` to reset to the default `status-style` colors from your configuration. Example: `#[default]`.

Show current date and day of the week, in a blue color:

```tmux
set -g status-right '#[fg=#4EA1FF]%Y-%m-%d %T %A'
# you might need to make the section max-width to make room
set -g status-right-length 40
```

Show the name of the current session (`#S`), the number of clients connected to the session in parentheses, in blue text. And show a magnifying glass on the left when `zoom mode` is active:

```tmux
set -g status-left'#[fg=#4EA1FF]#{?window_zoomed_flag,🔍,}[#S(#{session_attached})]'
# you might need to make the section max-width to make room
set -g status-right-length 20
```

The default styles and colors are set by the `status-style` option. When you use `#{default}` to reset styles, this is what it will use as the default.

You can also set a different style for the active session "tab" on the status line with `window-status-current-style`.

```tmux
set -g status-style bg='#111111',fg='#CCCCCC',us='#CCCCCC'
set-option -g window-status-current-style fg=#BD5EFF
```

TODO: screen shot

## Starting (and Exiting) `tmux`

Start `tmux` from the terminal:

```zsh
tmux
```

Start `tmux` and attach to an existing session:

```zsh
tmux attach
```

Start `tmux`, attaching to an existing session, if one exists, or else creating a `new-session`, and name the session 'my-session':

```zsh
tmux new-session -AD -s my-session
```

To exit `tmux`, exit out of each terminal by using the `exit` command, or `Ctrl+d`. Once every terminal is closed, `tmux` will exit.

Alternatively, you can `detach` from your session using `C-a d`. This will leave everything in place so you can re-attach later and pick up where you left off.

## Important Keybindings

Every command has to start with the `prefix` key. Entering the `prefix` key will set `tmux` into a state where it will interpret the next keystroke as a command. For example, if you mapped the `prefix` to `C-a`, you would press `C-a` followed quickly by `c` to create a new window. This would be written as `C-a c`, or just `c` because the `prefix` is assumed.

- `C-o` - Rotate the panes in the current window
- `C-z` - Suspend the `tmux` client to the background

## Commands

## `tmux-send-keys`

## `tmux` or `screen` on the server

## Plugins and Alternatives

