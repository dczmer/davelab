# Configuring ZSH For Everyday Use 01 - Basic ZSH Configuration

## Overview

Your `zshrc` file contains configuration and customization that will be applied to every interactive `zsh` session. By default, this configuration file is `~/.zshrc` ("~" is an alias for your home directory).

In this section, we'll cover some core, global configuration settings, as well as managing your command history.

An example [`zshrc-example.zsh`](./zshrc-example.zsh) file has been provided with the configuration options discussed in this chapter. The example file is fully commented with descriptions of every line.

For the most part, you just need to read-along and try the suggested exercises along the way. The exercises mostly amount to running a command at the terminal and observing the change that the various configuration options make.

## Exploring the Example Configuration

Open this document in a window, on one side of your screen, and open your terminal emulator on the other half.

Start a fresh `zsh` session:

```zsh
zsh -df
```

This will enter a clean `zsh` shell with NO configuration (only the default settings).

When you want to apply the contents of the example file (or your own test files), you can `source` those files to import them into the current session:

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

Use the `up` and `down` arrow keys to cycle through the entries at the terminal. You can hit enter/return to re-run the command or use the `left` and `right` arrow keys to move around and edit the command first.

Press `ctrl+r` and start typing 'hello' when prompted for a search.

Try navigating back to the `find` command, and changing `.md` to `.zsh` to search for `zsh` files instead of markdown.

## Custom Environment Varibles

Environment variables can store values in your shell session or script. Some applications, including `zsh`, will look for specific environment variables in your session and use those variables as configuration.

You should always set the `EDITOR` variable to point to the CLI text editor you prefer to use. When other programs want you to edit a file, like `git`, they will open that file with your chosen editor.

You will also frequently need to manage your `PATH` environment variable. This is what `zsh` will use to find a command. If you type a command name, without providing the path to that command file, then `zsh` looks through all of the directories listed in `PATH` and checks each one for the command.

```zsh
# use 'vim' as my editor
export EDITOR='vim'
# look for my custom scripts in a bin folder in my home directory ("~")
export PATH="$PATH:~/bin"
```

The `export` is required for the variable to persist in your shell environment. Otherwise, it would only be local to the current script file.

## Aliases

Use aliases to simplify entering long or repetitive tasks.

```zsh
alias -- lll='ls --color -all'
```

This will make a new command, `lll`, which is just the same as typing `ls --color -all`. Anything you type after the command will be forwarded as arguments to the real command.

```zsh
lll ~/bin
# is the same as
ls --color -all ~/bin
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

If you use `vim` or `emacs`, then `zsh` can use the normal keybindings from those editors to edit your command text at the prompt. If you don't use either of those, you can ignore this option:

```zsh
# use vim keybindings
bindkey -v
```

### The Line Editor

The `zsh` line editor will let you open your `EDITOR` with the contents of the command you are currently entering at the prompt. There, you can edit the command like a normal text file. When you save and exit, the full command will be pasted at the command line, ready to enter.

First, you need to enable it, and bind a key to start it:

```zsh
autoload edit-command-line
zle -N edit-command-line

# bind ctrl+e to start the line editor.
bindkey "^e" edit-command-line
```

#### Try it Out

First make sure the `zshrc-example.zsh` file has been sourced into the current session.

```zsh
zsh -df
source ./zshrc-example.zsh
```

Start typing a command, `ls /bin` but do not press enter/return. Now press `Ctrl+e` to launch the editor.

In the text editor, change the text from `ls /bin`, to `find . -name '*sh'`. Save the file and exit the editor. Press enter to run the command.


## Making a Modular Configuration

As you add more and more useful aliases, environment variables, and custom configuration options, you may find that you need to modularize your configuration.

For example, if you have a lot of common aliases that you want to keep in a separate file, you can import that file in your `zshrc` file.

```zsh
source ./aliases.zsh
# or
. aliases.zsh
```

## Managing Your Configuration as a Git Repository

You should manage your `zshrc` configuration as a `git` repository. This will allow you to back it up and easily copy it to other machines. It will also let you create checkpoints by making local commits whenever you make a change. If you really mess up, you can just go back to the previous commit.

1. Create a new repository somewhere. Example: `git init ~/src/my-zshrc`
2. Copy your custom `zshrc` file, or the provided [`zshrc-example.zsh`](./zshrc-example.zsh), to that repository and call it `zshrc.zsh`.
3. If you have additional source files/modules, put them in the same directory.
4. Add all the files to the repository and make an initial commit.
5. Now you can make a symbolic link to point `~/.zshrc` to your `zshrc.zsh` file.

```zsh
cd ~
ln -s ~/src/my-zshrc/zshrc.zsh .zshrc
```

---

[NEXT >>](../02_prompt/README.md)
