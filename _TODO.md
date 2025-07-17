TODO:

- inline the 'developer experience' folder and flatten to just one category
- learn jekyll or astro to work on local version of github pages:
    * use `_drafts` to keep WIP pages; accessible in dev server but not in site
    * setup custom actions to build and publish the site
- rework each page into static site; update text, formatting, headings accordingly
- create a site layout that makes it easy to navigate the course three effectively:
    * and responsive for people who keep their browser on 1/2 of the screen ;)
    * no js, or no build/lib js... maybe one web component for fun
- more examples and images, better test/example data

---

<details>
<summary>TODO: Future topics</summary>

- Diagramming:
    * buy a white-board
    * plantuml and mermaid (and a mention of graphviz)
    * modeling your ideas: Sequence diagrams, flow charts, simple class diagrams
        + Shout-out "UML Distilled" - TLDR "The good parts" of UML for real world application
    * C-4 diagrams, context diagrams
- Useful git-fu:
    * recovering from the reflog
    * finding commits in your branch that have not been merged yet `git diff <branch> --not master [--stat]`
    * graphs and `git log --all --decorate --oneline --graph`, `git show-branch`
    * `git bisect` (why it is great, and why it often doesn't work on large enterprise projects)
    * "pickaxe": `git log -S<PATTERN> --pretty=oneline --abbrev-commit <PATH>`
    * submodules and subtrees
    * `git add --patch/--interactive`
    * cherry-picking and interactive rebase
    * using another checkout as an alternate origin (share commits and branches from one git checkout with another checkout of the same repository)
- "Systems Thinking"
- Functional programming concepts
- Type systems and a bit of type theory

</details>

<details>
<summary>TODO: topics I'd like to add to developer productivity module:</summary>

- Feedback loops and exploratory programming
- Regex 101
- Personal Projects and Continuous Learning:
    * isolation and experimentation
    * using docker for development (dependencies as containers and how to work with projects on isolated containers)
    * why you should learn about C and make in 2025
    * prototype vs. porfolio project vs. actual product
- Modal text editing (not a tutorial on vim, an explanation of modal text editing, using vim as an example):
    * A sensible `vimrc` starting file and explanation
    * How to open, edit, move around, and exit; TLDR: I have to use vim for one thing, what's the minimum I need to know?
    * What is modal text editing?
    * Other modal text editors
    * Combining zsh line-editor with vim, and zsh vim keybindings
- Window managers and interacting with windows efficiently:
    * Keep your hands on the home-row of the keyboard
    * Tiling, stacking, cascading
    * Pinning or hot-keying most used windows (one key to get to terminal, editor, browser)
    * Automation and customization
- Linux as your daily driver
    - the terminal sections are for daily engineering tasks; this section would be for common system administration and management basics (how do i connect to wifi, etc.)
    - TLDR overview of memory and process management concepts

</details>

---

blogs about things i do? does anyone care?

- nixing things and developing with nix
- how i built my neovim editor
- journey to learn how to publish my own documentation site, the hard way, of course
- using obsidian => logseq => vimwiki => wiki.vim
