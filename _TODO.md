first, i just want to finish the breadth of the content i want to cover.
this isn't really where i want it yet.
the first course is pretty good, but the others lack interactivity and the way information is presented and grouped doesn't make a lot of sense. some of it just reads like a raw dump of random bits of information.

TODO:

- run better acc. audit
- imagemagick script to optimize images:
  * `mogrify avif *.png`
- template thing to automatically set the image sizes from the file metadata...
- grunt/make to minify+concat css, optimize imgs, bundle install, bundix, etc.
- create custom collections_dir "courses"
- dynamic menu, course navigation (up/down/contents/next/prev)
- light mode?
- license file:
  * properly credit:
    + css reset article https://www.joshwcomeau.com/css/custom-css-reset/
    + dracula theme


Updates:

- zsh config:
  * don't worry about learning all of the different commands and syntaxes in this section, just make sure you understand _what_ the lines are doing so you know exactly what your system is doing. once your shell is customized to your liking, you won't have to touch most of these lines ever again.
  * color scheme advice: use your shell because it has deeper integration into all systems in your shell
- image captions and alt text
- zsh prompt:
  * note: wc requires coreutils
  * more text coloring around the example descriptions (in "red text" ...)
  * mention zsh prompt generator webapps
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
  * fzf, rg/ag, fd

- do we need a section on how to install and use a package manager? who is my target audience...
