# Configuring ZSH For Everyday Use 04 Completed Configuration

# Objective

In this section, you will be presented with a completed `.zshrc` file and we'll discuss how you can merge it with your existing configuration (if you have one), as well as the things you probably want to modify or customize.

We'll also talk about some useful plugins that you may be interested in using, and how to install and manage them.

# Overview

You probably already have a default `~/.zshrc` file, with some things you've had to add when installing programs. You might also have some existing aliases or environment variables that you want to preserve. When adopting all (or part) of this configuration into your own file, you will want to be sure not to break anything you already have.

There are a few `zsh` plugins that I really like. Installing and managing plugins is pretty easy, and you likely won't need very many. But there are plugin managers and package managers you could use to install and configure plugins and color themes for you.

# Completing Your Configuration

The included file [`zshrc.zsh`](./zshrc.zsh) is the combined configurations from every section in this module. We didn't cover every single line that appears in this file, but every line is explained in the example `zsh` files included with all of the sections so far.

You can use this configuration file to replace/augment your existing `~/.zshrc` file.

You may already have some of the following:

- Custom variables and aliases
- Modifications to `$PATH`
- Commands for integration with other apps, like `pyenv`, `nvm`, etc. These are usually in the form of `source` or `.` commands, possibly within `if` conditional sections.

To merge the contents of the two files:

1. Make a backup copy of your existing `~/.zshrc` file.
2. Copy this [`zshrc.zsh`](./zshrc.zsh) file to `~/.zshrc`, replacing any existing file.
3. Go through your existing file, compare line-by-line to the example file.
4. Copy the lines that are missing to the _bottom_ of your new `~/.zshrc` file.

Things you may want to customize:

- The `EDITOR` variable should point to your preferred CLI text editor.
- The prompt-string (`$PS1`).
- The `git`/VCS format strings (`zstyle ':completion:'`), especially the icons.
- Enable `vim` or `emacs` keybindings (`bindkey -v` / `bindkey -e`).

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

[`fish-shell`](https://fishshell.com/) is a modern shell with lots of cool features and it's own shell scripting language with improved/modernized syntax and conventions.

However, there is a reason why I waited until the end to tell you about plugin managers and `fish`:

Even if you never change your `zshrc` again, doing it yourself helps you build a better mental model of how these things work, and gives you the context you need to change or fix things yourself.

I've known people who started out not being very comfortable on the command line, then they tried `fish` and suddenly started using it more and more. Eventually, most of those people ended up moving to `zsh` instead (usually with `oh my zsh`).

The three plugins we covered here are ports of the three most useful features from `fish`. The configuration we've done so far provides a very similar environment to `fish`. And, even though we haven't covered `zstyle` directly, we've seen enough that you could probably figure out how to customize your own color themes, or `source` a theme that someone else has made.

The other major feature of `fish` is the "sensible scripting" language. The down-side to this is that the scripts you write here are not portable to any other shell or execution environment.

I'd suggest sticking to `zsh` (or another `POSIX` compatible shell), and avoiding `fish`, but you might still like to use a plugin manager if you find it easier, or if you want an easy way to install color schemes.
