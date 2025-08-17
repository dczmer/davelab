TODO:

- dynamic menu, course navigation (up/down/contents/next/prev)
- create custom collections_dir "courses"
- run better accessibility audit
- template thing to automatically set the image sizes from the file metadata
- license file:
  * properly credit:
    + dracula theme
- customize gh actions:
  * build and deploy on nix-based container


Updates:

- `cheet sheets` and resources/links at the end of every module
- keybindings:
  * remove/replace some of my custom binds, like ctrl+e/home/end
  * list the emacs versions, or appropriate keybind command
  * make a section for the vim keybinds i use
  * alt-h:
    + lookup help for command you are typing
    + works by default with `bindkey -e` (might be default)
    + for vim keybindings: `bindkey -M vimcmd 'K' run-help` to follow vim conventions instead
  * alt-.:
    + auto insert the last argument to previous command (like using '!$')
    + for vim mode, you need to make a keybinding `bindkey -M viins '^[.' insert-last-word'`
- new "side-by-side" image
- image captions and alt text
- signals: ctrl+d
- `touch` command, `mkdir -p` tip
- about symlinks
- replace images with `ls -all` typo
- This might be a good reference to add for people who want to dive into writing auto-complete for an arbitrary command https://mill-build.org/blog/14-bash-zsh-completion.html
- section for newer command line tools and alternatives:
  * fzf, rg/ag, fd, bat


Future Course Ideas:

These seem like they might be better suited for a separate site, or a series of blogs about self-guided training, pet projects, programming for fun, etc.

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

- nix!:
  * easy intro: using nix package manger for development:
    + search and install packages in your profile
    + make a devShell (but no packaging):
      + dependency isolation
      + aliases and commands, env vars, etc
      + containers
  * what is nixos all about?
  * language and packaging primer and resources (not going to teach that here)

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
