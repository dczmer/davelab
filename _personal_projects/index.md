---
title: (TODO) Prototyping, Personal Projects, Self-Guided Learning
layout: default
lesson: 0
---

# Overview

{: .todo }
Coming soon.

When you start to do a lot of tutorials and to try out various libraries, frameworks, languages, etc. then you will find yourself dealing with dependencies and different versions of libraries and programming languages. How do you manage your dependencies and your development environment so that it's consistent, always uses the right versions, and doesn't interfere with the rest of your system's functionality.

For example, maybe you have `python3.11` installed on your operating system from a package manager, like `homebrew`. This means that, anywhere in your shell, you can run the command `python` and it will run this version. You may have other programs and utilities that depend on `python` being available, so this is the version that they will use also.

But perhaps you want to work on something different using `python3.14`. So you update your system `python` to that version, and now everything is using 3.14. Except, one of the projects or applications on your system has a problem and the required libraries does not support this new version of `python`. It would be better if every project or program could declare exactly which version of `python` they need, and their dependencies, instead of just using whatever `python` is in your global path.

Now, you can install multiple versions of `python` together on one host. Perhaps you use something like `pyenv`, which we'll cover later. But now you have a new problem: you run `pip install` to add a package, but when you go to run your program it says that module cannot be found. Either your `pip install` or the version of `python` that the system is picking up are not the same. So this module will cover debugging those kinds of issues as well.

Concepts and techniques that I plan to cover:

- Dependencies: local project dependencies, system dependencies, static and shared/dynamic dependencies.
- Dependency management: from system package managers, to things like `pyenv`, `pip + venv` / `poetry` / etc. I'll use `python` as the example language for discussion.
- Isolation (keeping things separate, not conflicting with your system or other programs, or maybe just keeping execution isolated from your system environment)
- Using `docker` for development: easily running services like `nginx` as a container, or how to run and develop your app on a container, where it has it's own isolated environment.
- How to plan and manage a simple pet project, and optimize for learning in the future.
- At the end, I'll do a quick demo of what you could do with `nix` package manager and "dev shells". `nix` has a steep learning curve, but you can use it as your normal package manager and use the "dev shells" with almost no required knowledge of `nix` language or semantics.
