---
title: Basic Scripting Intro
layout: default
lesson: 0
---
# Basic Scripting

Whenever you find yourself running the same sequence of commands repeatedly, you should make a shell script. It will save time and keystrokes, run the same way every time, is easy to copy and share, and you can add parameters and logic.

Anything you can do at the command line, you can put in a script. That means pretty much everything can be automated.

When we configured your shell, we were specifically configuring for `zsh`. When we write scripts, we'll be writing for `bash` instead. Since `zsh` is a super-set of `bash`, this is the most generally portable system to target.

{: .note }
We'll be writing scripts to target "bash", not "zsh" syntax.

## Requirements

If you are on Mac, then you should [install Homebrew](https://docs.brew.sh/Installation). This is your best option for installing and managing software.

Many of the commands and programs used in this chapter are from the `coreutils` project. On a Linux system, these may already be installed in your base system. If they are not, then you should be able to install them with your system package manager.

```zsh
brew install coreutils
```

- [First Steps](./01_first-steps)
- [Arguments and Variables](./02_arguments_and_variables)
- [Functions and Conditional Logic](./03_conditionals)
- [Arrays and Loops](./04_arrays_and_loops)
- [Strings](./05_strings)
- [Arithmetic](./06_arithmetic)
- [Lab: Basic Scripting](./07_lab1)

---

[NEXT >>](./01_first-steps)
