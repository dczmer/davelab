TODO:

- mention fish at the beginning, if they don't want to configure anything. but suggest they still read through.
- some interactivity in Basic Scripting
- section for newer command line tools and alternatives:
  * fzf, rg/ag, fd, bat
  * move jq section here
- fictional scenario and file system to run all examples/labs over:
  * the examples are more effective if you don't have to first create 30 json files to search through
  * a simple 'project' structure gives us some motivation/justification for doing various actions
  * provides a test bed and foundation to build the labs on
- `cheet sheets`, labs, and resources/links at the end of every module
- i feel like it needs some silly pictures of cats and some humor...
- follow/"test" the entire course on a fresh vm with zsh


Updates:

- new "side-by-side" image
- replace images with `ls -all` typo
- image captions and alt text


Project/site:

- dynamic menu, course navigation (up/down/contents/next/prev)
- create custom collections_dir "courses"
- run better accessibility audit
- template thing to automatically set the image sizes from the file metadata
- license file:
  * properly credit:
    + dracula theme
- customize gh actions:
  * build and deploy on nix-based container
- can i make some kind of non-js tracking pixel? just for counting page loads and metrics i can mine from the headers or client ip

---

Idea for future section or another project:

> Prototyping, Personal Projects, and Self-Guided Learning

because i've been talking to people who seem to have trouble with local development on personal projects, tutorials, etc. as well as managing dependencies and troubleshooting conflicting versions of packages. i'm also a big fan of doing personal projects for fun and learning, and want to show some of the ways i've made that easier for myself

- find something that you like, which is at least tangentially related to your work, and dive in:
  * even if it's not _directly_ applicable to your work, you will still learn new things that may be transferable and someday your work may _need_ someone with that domain knowledge
- using source control
- dependencies (including the programming language) and dependency management
- isolation with software
- isolation with containers (and tips for development)
- running services with docker
- notes and documentation
- planning, setting goals and expectations (and limitations)
- feedback cycles and optimizing for development and debugging
- making building blocks: templates, snippets, codegen, aliases, reference implementations and kMS
- lab:
  * use python + pyenv + pip/poetry/etc to make isolated project with git
  * debug problems with system python, packages not found, etc.
- very quick demo of a nix dev shell for the same project

NOTES:

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

- nix!:
  * easy intro: using nix package manger for development:
    + search and install packages in your profile
    + make a devShell (but no packaging):
      + dependency isolation
      + aliases and commands, env vars, etc
      + containers
  * what is nixos all about?
  * language and packaging primer and resources (not going to teach that here)
