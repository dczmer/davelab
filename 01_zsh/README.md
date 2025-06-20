# DaveLab 01: Intro to Shell Scripting with ZSH

A crash-course on command-line productivity.

This is a short introduction to customizing and using the shell for basic tasks.

There is a (much) more in-depth user guide you can find [here](https://zsh.sourceforge.io/Guide/zshguide.html).

If you are interested in a `zsh` reference, you can check out the [ZSH Manual](https://zsh.sourceforge.io/Doc/Release/zsh_toc.html)

## Contents

- [Basic ZSH configuration](./01_zsh-config/README.md)
- [Customizing your prompt](./02_prompt/README.md)
- [Moving around efficiently](./03_moving-around/README.md)
- [I/O streams and gnutools](./04_streams-gnutools/README.md)
- [Basic scripting](./05_basic-scripting/README.md)
- [Using ZSH plugins and powerline](./06_powerline-plugins/README.md)
- [Using tmux](./07_tmux/README.md)

## How to Explore this Course

Before you do anything else, make sure you install a command line text editor and learn how to enter text, save, and exit. A very simple one is `nano`, which you can install with a package manager, like `homebrew`.

### 1. Install ZSH

First, you will need to make sure you have `zsh` installed.

If you are using a Mac, then this is the default shell already. However, you should consider installing a better terminal emulator like [iTerm](https://iterm2.com/), or [kitty](https://github.com/kovidgoyal/kitty) (via [homebrew](https://brew.sh/)).

If you are on Linux or WSL, you will need to be sure you have it installed. We'll be starting `zsh` sessions manually, so you don't have to set it up as your default shell to follow these examples, if you don't want to.

The instructions vary, depending on your specific operating system or distribution, but it usually involves installing the `zsh` package from your package manager. Making it your default shell can be done either in the settings for your terminal emulator, or by using the `chsh` command.

### 2. Navigating the Chapters

This project is structured as a `git` repo, intended to be hosted on a platform where you can easily view `README.md` files in a web browser (like `github`).

You should have this repository checked out already. In your shell, navigate to the directory for each chapter as you go.

The chapters are sorted numerically. Start at chapter '01' and continue in order.

Each chapter has a `README.md` file with the course material, as well as one or more other example files. This means you can read the source material in the browser via `github` UI, while you work in a terminal. Try putting your browser on one side of your desktop, and your terminal on the other side, so they both take up exactly half of the screen.

Each section will briefly cover the material, then explain how you can try it out and experiment.

### 3. Running the Examples

We can test configuration files and shell scripts by starting a fresh `zsh` session in your terminal. This will ensure we're working from a clean slate, with zero custom configuration, so we can experiment with changing settings, and be sure scripts and commands will work consistently.

To start, open your terminal emulator and start a new `zsh` session (even if you are already using `zsh` as your default shell):

```zsh
zsh -df
```

You may notice the prompt change to the default, which is just your system's hostname and a '%' character.

Then you can `source` the configuration file that you want to test:

```zsh
source example_config.zsh
```

You can `source` your file again, to apply changes, or you can `exit` to go back to the shell environment from before you typed `zsh -df`.
