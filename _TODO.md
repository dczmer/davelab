TODO:

- run better accessibility audit
- template thing to automatically set the image sizes from the file metadata...
- dynamic menu, course navigation (up/down/contents/next/prev)
- create custom collections_dir "courses"
- license file:
  * properly credit:
    + dracula theme
- customize actions:
  * build on nix


Updates:

- alt-h:
  * lookup help for command you are typing
  * works by default with `bindkey -e` (might be default)
  * for vim keybindings: `bindkey -M vimcmd 'K' run-help` to follow vim conventions instead
- alt-.:
  * auto insert the last argument to previous command (like using '!$')
  * for vim mode, you need to make a keybinding `bindkey -M viins '^[.' insert-last-word'`
- image captions and alt text
  * note: wc requires coreutils
- zsh completion:
  * sed, find requires coreutils
- zsh completed setup:
  * what is posix/link
- tmux basic usage: muscle memory will automate the keybindings eventually
- signals: ctrl+d
- about symlinks
- distinct style for visited links
- side-by-side image
- images with `ls -all`
- some basic analytics


Future Course Ideas:

- dependency management and isolation concepts:
  * isolation:
    + what/why
    + dual boot (not usually needed these days)
    + vms (old but still valid for best isolation)
    + containers
    + software (pyenv/venv/etc)
  * dependencies:
    + local/static
    + system/dynamic
  * dependency management:
    + package managers
    + lock files
    + per-project dependency management and isolation (pyenv+pip, etc)
    + nix, flatpack, etc.

- pet projects:
  * why linux is a good OS for development and learning
  * a bit of `make`
  * keeping a KMS and journal
  * docker for development:
    + quickly trying an app without building or installing
    + local services for dev, like mysql, redis, etc
    + developing and running on a container:
      + why it complicates things
      + when/why you would want to do it (or not)
      + making it less painful (bind-mounts, layering, composition)

- feedback cycles and debugging

- keyboard-centric interaction (cli, linux, window managers, hot keys, fzf, etc.)

- typing, type systems, and a bit of type theory

- nix!

- newer command line tools and alternatives:
  * fzf, rg/ag, fd, bat
