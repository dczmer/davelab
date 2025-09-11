---
title: Basic ZSH Configuration
layout: default
lesson: 1
---
# Basic ZSH Configuration

- TC
{:toc}

## Overview

Your `zshrc` file contains configuration and customization that will be applied to every interactive `zsh` session. By default, this configuration file is `~/.zshrc` ("~" is an alias for your home directory).

In this section, we'll cover some core, global configuration settings, as well as managing your command history.

An example [zshrc-example.zsh](./zshrc-example.zsh) file has been provided with the configuration options discussed in this chapter. The example file is fully commented with descriptions of every line.

For the most part, you just need to read-along and try the suggested exercises along the way. The exercises mostly amount to running a command at the terminal and observing the change that the various configuration options make.

## Exploring the Example Configuration

Open this document in a window, on one side of your screen, and open your terminal emulator on the other half.

Start a fresh `zsh` session:

```zsh
zsh -df
```

This will enter a clean `zsh` shell with NO configuration (only the default settings).

When you want to apply the contents of the [example file](./zshrc-example.zsh) (or your own test files), you can `source` those files to import them into the current session:

```zsh
source ./zshrc-example.zsh
```

When you make changes the example file you will need to `source` it again.

If you want to go back to a clean shell and start over, type `exit` or press `ctrl+d` to go back to your regular shell, and you can start again.

## Command History

The command history is a major key to unlocking command line productivity. 

The most important things to configure are the location and size of your history file, and whether you want to share your history across terminal instances or only keep the history of the current session.

Since it's likely you will find yourself using multiple terminals at once to get your job done, you probably want to share your history across all terminals and keep it around for a long time.

```zsh
HISTFILE="$HOME/.zsh_history"
HISTSIZE="50000"
SAVEHIST="50000"
setopt SHARE_HISTORY
setopt APPEND_HISTORY
```

This sets a single history file location for all sessions to use, and will keep up to 50,000 entries in that file. When the history size is exceeded, the oldest commands in the file will be deleted.

You can save space by de-duplicating the entries in your history file. However, it is often very useful to cycle through entries in your history, in sequence, to replay a series of repeated commands. In that case, you would want to keep the duplicate commands so you can play them back in the correct order.


```zsh
# This first one means do ignore _consecutive_ duplicate commands in the same session.
# if you type the exact same command multiple times in a row, only store it once.
setopt HIST_IGNORE_DUPS

# IGNORE_ALL_DUPS means globally de-dupe the history. We don't want this.
unsetopt HIST_IGNORE_ALL_DUPS

# Allow treating duplicates like any other history entries.
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
unsetopt HIST_EXPIRE_DUPS_FIRST
```

The extended history option will record additional information in the history file: the time when the command was entered, and how long it ran.


```zsh
setopt EXTENDED_HISTORY
```

### Try it Out

Start a new `zsh` session and `source` the example file:

```zsh
zsh -df
source ./zshrc-example.zsh
```

Now type a few commands:

```zsh
ls
ls -al
find . -name '*.md'
echo 'hello world'
```

Print the last few entries from the history:

```zsh
tail ~/.zsh_history
```

You can use the `up` and `down` arrow keys to cycle through the entries from your history file at the command prompt. You can hit enter/return to re-run the command or use the `left` and `right` arrow keys to move around and edit the command first.

Press `ctrl+r` and start typing 'hello' when prompted for a search.

Try navigating back to the `find` command, using either the arrow keys or `ctrl+r` search, and change `.md` to `.zsh` to search for `zsh` files instead of markdown.

## Custom Environment Varibles

Environment variables can store values in your shell environment, like global options or settings. Some applications, including `zsh`, will look for specific environment variables in your session and use those variables as configuration.

You should always set the `EDITOR` variable to point to the CLI text editor you prefer to use. When other programs want you to edit a file, like `git`, they will open that file with your chosen editor.

You will also frequently need to manage your `PATH` environment variable. This is what `zsh` will use to find a command. If you type a command name, without providing the path to that command file, then `zsh` looks through all of the directories listed in `PATH` and checks each one for the command.

```zsh
# use 'vim' as my editor
export EDITOR='vim'
# look for my custom scripts in a bin folder in my home directory ("~")
export PATH="$PATH:~/bin"
```

The `export` is required for the variable to persist in your shell environment. Otherwise, it would only be local to the current script file.

Try printing the contents of your current `PATH` variable:

```zsh
echo $PATH
```

## Aliases

Use aliases to simplify entering long or repetitive tasks.

```zsh
alias -- ll='ls --color -al'
```

This will make a new command, `ll`, which is just the same as typing `ls --color -al`. Anything you type after the command will be forwarded as arguments to the real command.

```zsh
ll ~/bin
# is the same as
ls --color -al ~/bin
```

Another common use for aliases is to make short abbreviations for common commands:

```zsh
# 'gc' is short for 'git commit'
alias -- gc='git commit'
# 'gca' will do `git commit -am`
alias -- gca='gc -am'
```

Now you can commit everything at once with a very short command.

```zsh
gca "commit message"
```

Whenever you have a complicated command, or frequently used command and you want to save yourself some keystrokes, use an alias. When you need to work with arguments, or when the alias gets too long or complicated, consider using a function or script file instead.

## Custom Keybindings

You can make your own custom keybindings to invoke special `zsh` functions. Here are a couple that I always use:

```zsh
# let's you search history in reverse with ctrl+r. we'll cover this later.
bindkey "^R" history-incremental-search-backward

# Bind home + end to navigate to front and end of line.
# Start typing a long command and then press `home`.
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
```

{: .note }
If the last two `bindkey` using the "`terminfo`" variable don't seem to work, you can figure out the exact keycode values to use by pressing "`<ctrl+v>`" and then pressing the key. See the next section for more details.

### Terminfo

Not every system has the same underlying key-code values, which can make using keybindings difficult between multiple operating systems and distributions. Some systems give you this handy `$terminfo` variable that you can use to look up keycodes from a mapping. Some systems do not have this.

To find out exactly what codes your system defines, use `<ctrl+v>` (default/`emacs` mode), or `<ctrl+q><ctrl+v>` (`vi` mode) and then press the key you want to map. The keycode value you need to use will be inserted at the position of the cursor.

For example, you may need something like this:

```zsh
<ctrl+v><Home>
# ^[[1~

<ctrl+v><End>
# ^[[4~
```

Then you would need to fix your keybindings, like this:

```zsh
# alternate keybindings, if the above do not work
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
```

### Keybinding Modes

There are two keybinding configurations that ship with `zsh`: `emacs` or `vi`. By default, it uses the `emacs` mode.

But if you are used to `vi` commands, then you may prefer to set `vi` mode:

```zsh
# use vim keybindings
bindkey -v
```

This changes all of the default keybindings and allows you to edit your command line input like a buffer in `vim`: hit `Esc`, move to the beginning with `0`, move the end with `$`, replace the next word with `ciw`, etc.

The different keybinding modes have different sets of functions mapped by default. For example, `vi` mode doesn't have a keybinding for `end-of-line` by default, because you can do that with standard `vi` commands. But `emacs` mode sets that to `ctrl+e` by default.

If you have the default `emacs` mode enabled, you don't really need to map `beginning-of-line` or `end-of-line`, because they are already mapped to `ctrl+a` and `ctrl+e`, respectively. But, you can also map them to `home` and `end` if you want.

### Line Editor and Keybinding Reference

The keybinding interface, and the list of functions that are available for mapping, are provided by the `zle` (`zsh` line editor) module.

The functions that we map to the keybinding are called "widgets."

To get help, run `man zshzle` to see the manual page for the `zsh` line-editor.

Search for `ZLE WIDGETS` to find details about how widgets work, and how to implement your own with a shell function.

Search for `STANDARD WIDGETS` to see the list of included widgets and their default mappings. Since there are three potential ways to map any widget - `emacs`, `viins` and `vicmd` (`vi` insert and command modes) - then you will see three mappings next to each widget.

The mappings go in order, as described in this section of the manual:

> WIDGET (emacs), (viins), (vicmd)

Let's use the `beginning-of-line` widget as an example:

> beginning-of-line (^A) (unbound) (unbound)

In this example, the default keybindings for the `beginning-of-line` widget are:

1. `^A` (`ctrl+a`) for `emacs` mode.
2. Unbound for `viins` mode.
3. Unbound for `vicmd` mode.

If you want to make a custom keybinding for one specific widget mode only, you can use `-M` and the target type:

```zsh
bindkey -M vimcmd 'K' run-help
```

This keybinding makes `K` (capital "K") show the `man` page for the current command you are entering at the prompt. But in `emacs` mode, this is already mapped to `Alt+h` by default.

Another mapping I like to steal from `emacs` mode for my `vi` keybindings is `Ctrl+.` to automatically insert the last argument of the previous command.

```zsh
bindkey -M viins '^[.' insert-last-word'
```

```zsh
mkdir /tmp/hello

echo <ctrl+.>
# /tmp/hello
```

This same functionality is also available by using the special `!$` variable directly:

```zsh
mkdir /tmp/hello

echo !$
# /tmp/hello
```

### edit-command-line

The `zsh` line editor provides a widget that will let you open your `EDITOR` with the contents of the command you are currently entering at the prompt. There, you can edit the command like a normal text file. When you save and exit, the full command will be pasted at the command line, ready to enter.

First, you need to enable it, and bind a key to start it:

```zsh
autoload edit-command-line
zle -N edit-command-line

bindkey "^z" edit-command-line
```

{: .note }
I personally use `vi` mode, so I don't have a good suggestion for a default `emacs` binding. I suggested "`ctrl+z`" because it's an easy shortcut that doesn't conflict with any other default mappings for this mode.

I have this mapped to `ctrl+e` in `vi` insert mode (`ctrl+e` is already mapped to `end-of-line` in `emacs` mode):

```zsh
# bind ctrl+e to start the line editor.
bindkey -M viins "^e" edit-command-line
```

This is particularly useful when your commands start to get complicated or take up multiple lines, or when you have to make heavy edits to a previous command from your history. You can also just write the command to a file from your editor to save it as the beginning of a script.

#### Try it Out

First make sure the `zshrc-example.zsh` file has been sourced into the current session.

```zsh
zsh -df
source ./zshrc-example.zsh
```

Start typing a command, `ls /bin` but do not press enter/return. Now press `Ctrl+z` to launch the editor.

In the text editor, change the text from `ls /bin`, to `find . -name '*sh'`. Save the file and exit the editor. Press enter to run the command.


## Making a Modular Configuration

As you add more and more useful aliases, environment variables, and custom configuration options, you may find that you need to modularize your configuration.

For example, if you have a lot of common aliases that you want to keep in a separate file, you can import that file in your `zshrc` file.

```zsh
source ./aliases.zsh
# or
. aliases.zsh
```

### Managing Your Configuration as a Git Repository

You should manage your `zshrc` configuration as a `git` repository. This will allow you to back it up and easily copy it to other machines. It will also let you create checkpoints by making local commits whenever you make a change. If you really mess up, you can just go back to the previous commit.

1. Create a new repository somewhere. Example: `git init ~/src/my-zshrc`
2. Copy your custom `zshrc` file, or the provided [zshrc-example.zsh](./zshrc-example.zsh), to that repository and call it `zshrc.zsh`.
3. If you have additional source files/modules, put them in the same directory.
4. Add all the files to the repository and make an initial commit.
5. Delete the existing `~/.zshrc` file, if it exists (maybe make a backup).
6. Now you can make a symbolic link to point `~/.zshrc` to your `zshrc.zsh` file.

```zsh
# "link" my zshrc.zsh file to ~/.zshrc
cd ~
ln -s ~/src/my-zshrc/zshrc.zsh .zshrc
```

---

[NEXT >>](./02_prompt)
