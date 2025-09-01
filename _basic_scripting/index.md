---
title: (TODO) Basic Scripting Intro
layout: default
lesson: 0
---
# Basic Scripting

When we configured your shell, we were specifically configuring for `zsh`. When we write scripts, we'll be writing for `bash` instead. Since `zsh` is a super-set of `bash`, this is the most generally portable system to target.

{: .note }
We'll be writing scripts to target "bash", not "zsh" syntax.

## Requirements

If you are on Mac, then you should [install Homebrew](https://docs.brew.sh/Installation). This is your best option for installing and managing software.

Many of the commands and programs used in this chapter are from the `coreutils` project. On a Linux system, these may already be installed in your base system. If they are not, then you should be able to install them with your system package manager.

```zsh
brew install coreutils
```

{: .todo }
Coming soon!

- [First Steps](./01_first-steps)
- [Arguments and Variables](./02_arguments_and_variables)
- [Functions and Conditional Logic](./03_conditionals)
- [Arrays and Loops](./04_arrays_and_loops)
- [Strings](./05_strings)
- arithmetic and arrays:
  * `$(( ))`
  * bc
- lab: basic scripting

---

[NEXT >>](./01_first-steps)
