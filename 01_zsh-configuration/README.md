# Developer Productivity 01 - Configuring ZSH For Everyday Use

## Overview

By the end of this module you will have created your own customized `zshrc` file that you can use to replace/augment your existing configuration, to make it much easier to perform tasks in the shell. Importantly, you will know what every option in that configuration file does and how to change it.

Some of the syntax and conventions may seem strange or complicated. You can just take the completed configuration file from the final section and use that as your own `zshrc`. The sections in this module will walk through the important lines from that configuration file so that you know what they do, and how to customize them.

> WARNING: You probably have an existing `~/.zshrc` file, and it might have important stuff you want to preserve. If you decide to replace your configuration file, be sure to make a backup first! There will be a section at the end with some guidelines for merging with your existing configuration.

## How to Explore this Course

### CLI Text Editor

Before you do anything else, make sure you install a command line text editor and learn how to enter text, save, and exit. Editing configuration files from the command line is a common chore, so make sure you are comfortable with it first.

You might try using `neovim` or `emacs`, because I want to talk about modal text editing later. The learning curve is steep, but just taking the plunge and forcing yourself to use it as your daily driver will help you train and build muscle memory much faster.

Otherwise, `nano` is probably the easiest way to get started. It's keyboard driven, but it has a menu that shows you the important keybindings while you are editing. Run `man nano` and read the `DESCRIPTION` and `EDITING` sections.

I recommend learning `vim` and `nano` because those are usually available on every system. When you have to shell to a remote server and fix something, those will probably be your only options.

### Install ZSH

First, you will need to make sure you have `zsh` installed.

If you are using a Mac, then this is the default shell already. However, you should consider installing a better terminal emulator like [iTerm](https://iterm2.com/), or [kitty](https://github.com/kovidgoyal/kitty) (via [homebrew](https://brew.sh/)). 

If you are on Linux or WSL, you will need to be sure you have it installed.

The instructions vary, depending on your specific operating system or distribution, but it usually involves installing the `zsh` package from your package manager. Making it your default shell can be done either in the settings for your terminal emulator, or by using the `chsh` command.

### Running the Examples

We can test configuration files and shell scripts by starting a fresh `zsh` session in your terminal. This will ensure we're working from a clean slate, with zero custom configuration, so we can experiment with changing settings and be sure scripts and commands will work consistently.

To start, open your terminal emulator and start a new `zsh` session:

```zsh
zsh -df
```

You may notice the prompt change to the default, which is just your system's hostname and a '%' character.

Then you can `source` the configuration file that you want to test:

```zsh
# example:
source example_config.zsh
```

## Contents

In this module, we will walk through setting up a basic `zsh` shell environment.

- [Basic ZSH configuration](./01_zsh-config/README.md) will cover configuring how your command history works, and adjusting some global settings.
- [Customizing your prompt](./02_prompt/README.md) will cover how to create a custom prompt string, and we'll talk about prompt generators and other tools that might automate the process for you.
- [The completion system](./03_completion/README.md) will cover how to enable and customize the completion engine, which will help you enter commands correctly by showing you the valid options and letting you pick from a menu.
- [Finishing your set-up](./04_complete-setup/README.md) will talk about some random topics, like plugins, plugin managers, and other shells you might find interesting. Then we'll cover how to merge the final `zshrc` that we made in this module into your existing `zshrc` file.

---

[NEXT >>](./01_zsh-config/README.md)
