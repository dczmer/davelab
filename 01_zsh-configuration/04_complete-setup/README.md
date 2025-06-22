# 04 Completed Configuration

# Completed Configuration

The included file `zshrc.zsh` is the combined configurations from every section in this module. We didn't cover every single line that appears in this file, but every line is explained in the example `zsh` files included with all of the sections so far.

You can use this configuration file to replace/augment your existing `~/.zshrc` file.

TODO:
- things you want to save/merge from your existing config
- lines you probably want to customize

# Plugins

## `zsh-syntax-highlighting`

The [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) will colorize command text as you are typing. Valid command names are in green, invalid command names are red, mismatched brackets and strings will be highlighted, etc. This helps with catching syntax errors.

![image](./images/syntax-highlighting.png)

## `zsh-history-substring-search`

The [`zsh-history-substring-search`](https://github.com/zsh-users/zsh-history-substring-search) plugin lets you type any substring of a previous command and then use the `up` and `down` arrow keys to cycle through history items. This is marginally more convenient than using `ctrl-r` to search through history items in some cases.

## `zsh-autosuggestions`

The [`zsh-autosuggestions`](https://www.nerdfonts.com/font-downloads) plugin will show inline suggestions as you type. The suggestions come from doing a substring search through your history, starting from most recent entries.

![image](./images/autosuggestions.png)

If you want to accept the suggestion, press the right arrow key (`->`).

You can configure how the suggestions are styled and if suggestions should be based on your command history or based on completion options.


## Installing Plugins

To install a `zsh` plugin, you just need to `source` the main `.zsh` file from that plugin folder. So you can download or clone the project from `github`, or you can usually install them with a package manager like `dnf` or `homebrew`. When you install with a package manager, you may have to do a little searching to find the exact location of the plugin folder, so you know how to write the `source` statement.

There are also several plugin managers, but the most popular ones I know of are:

- [`zplug`](https://github.com/zplug/zplug)
- [`oh my zsh`](https://github.com/ohmyzsh/ohmyzsh)

A word of warning, however: You probably don't need/want that many `zsh` plugins to necessitate a plugin manager that is also a package manager. I suggest installing them with your normal package manager, because that way they get updated with everything else when you run updates.

# `fish-shell`

[`fish-shell`](https://fishshell.com/) is a very fancy and pretty shell, with lots of cool features, and it's own shell scripting language with improved/modernized syntax and conventions.

However, there is a reason why I waited until the end to tell you about plugin managers and `fish`:

Even if you never change your `zshrc` again, doing it yourself helps you build a better mental model of how these things work, and gives you the context you need to change or fix things yourself.

You don't need a plugin manager. You don't need an additional package manager to download `zsh` plugins. We've already installed the three most useful plugins, and installing a plugin is simple. But if you decide to use one, at least you have some idea what it is doing.

As for `fish` - I've known many people who started out not being very comfortable on the command line, then they tried `fish` and suddenly started using it more and more. Eventually, most of those people ended up moving to `zsh` instead (usually with `oh my zsh`).

The three plugins we covered here are ports of the three most useful features from `fish`. The configuration we've done so far provides a very similar environment to `fish`. And, even though we haven't covered `zstyle` directly, we've seen enough that you could probably figure out how to customize your own color themes, or `source` a theme that someone else has made.

The other major feature of `fish` is the "sensible scripting" language. The down-side to this is that the scripts you write here are not portable to any other shell or execution environment.

I'd suggest sticking to `zsh`, and avoiding `fish`, but you might still like to use a plugin manager if you find it easier, or if you want an easy way to install color schemes.
