## `fzf`

(WIP - notes from working out my own configuration)

### Configuring

- also install `ripgrep` and set `FZF_DEFAULT_COMMAND`:
    - `export FZF_DEFAULT_COMMAND="rg --files --hidden --glob *"`
    - `rg` will filter/exclude `.gitignore` files automatically
- add `eval "$(fzf --bash)"` to `~/.zshrc`
    - optionally unset these keybindings with vars: `FZF_ALT_C_COMMAND= FZF_CTRL_T_COMMAND= fzf ...`
    - instead, set them to the same thing as `FZF_DEFAULT_COMMAND`
        - `export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"`
        - `export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"`
- then `alias -- fzf="fzf --tmux"`
- export default options in `~/.zshrc` with `FZF_DEFAULT_OPTS`
    - `export FZF_DEFAULT_OPTS="--tmux "`
    - or `export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/fzfrc` and use that file

theme designer: config/lua/dave-vim/plugins/nvim-colorizer-lua.lua
```zsh
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#CCCCCC,fg+:#FFBD5E,bg:#121212,bg+:#262626
  --color=hl:#4EA1FF,hl+:#00a0fd,info:#FFBD5E,marker:#5EFF6C
  --color=prompt:#FF6E5E,spinner:#BD5EFF,pointer:#BD5EFF,header:#4EA1FF
  --color=border:#262626,preview-fg:#000000,preview-bg:#262626,label:#aeaeae
  --color=query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="󰋇 " --separator="─" --scrollbar="│"'
```

### Using

- pipe anything into `| fzf` and then you can fuzzy search it
- uses somewhat regex-like search modifiers. single quotes indicate word boundaries, `^` and `$` anchor to start or end, invert with `!`. "or" together with `|`.
- if yo do something like `command | fzf > outfile` then it will save your selections to that text file when you are done
- shell integration:
    - `ctrl+t` - paste selected entries into the command line to complete a command
    - `ctrl+r` - paste selected command history entry to command line
    - `alt+c` - cd into selected directory
    - `**<TAB>` - trigger completion using `fzf` instead of zsh completion engine (`vim ~/test/**<TAB>`)
- in the finder:
    - `ctrl+k`/`ctrl+j` (or `ctrl+p`, `ctrl+n`) move cursor up and down
    - `enter` to select the item
    - `ctrl-c` / `ctrl-g` / `esc` to exit
