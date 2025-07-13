# Developer Productivity 02 - Expansion (and some misc utilities)

## Overview

This section will cover "shell expansion" and a few other useful tips that didn't really fit anywhere else.

## Expansion and "Globbing"

TODO: what is expansion, etc.

### `*`, `?`, `{}`

TODO

### `!?` and `!!`

Your shell has a lot of convenience variables and aliases that you can use to make your life easier.

Two that I use frequently are `!$` and `!!`.

- `!$` - This will be replaced with the _last_ parameter from the previous command you ran.
- `!!` - This will be replaced with the _entire_ previous command.


```zsh
mkdir test
ls !$
touch !$/file.txt
file !$
git add !$
```


```zsh
touch /etc/test.test
# touch: /ect/test.test: Permision denied

sudo !!

rm -f !$
# rm: /ect/test.test: Permision denied

sudo !!
```

### Quoting and escaping

TODO

## Using `pushd`/`popd`

Sometimes you may need to temporarily change to a different directory and run a few commands, but you don't want to lose your spot. If you use `pushd` and `popd`, you can save your place in a "stack" of directory bookmarks and then return to them when you are done.

Use `pushd` to move to a new directory and save your place on the `dirs` stack. Try the following sequence of commands:

```zsh
cd ~
pushd /tmp
touch test.txt
dirs -v
popd
```

![image](./images/pushd.png)

You can put something in your [prompt string](../../01_zsh-configuration/02_prompt/README.md) to show how many levels of directories are on the stack:

```zsh
$(dirs -v | wc -l | xargs)
```

## Jobs

By default, when you run a command from the command line, it will run in the _foreground_ - it takes control of your input and output for that terminal until it is completed.

Sometimes you want a long-running command to run in the _background_, where it will run asynchronously, and you can continue doing other work in that same terminal. Other times, you might want to suspend the program you are currently interacting with, drop back to the shell, do something else, then either resume interacting with your application or send it to the background.

- `ctrl-z` - Suspend the current task and drop back to the shell.
- `jobs` - Command to print the number of suspended or background jobs you have active in your shell session.
- `fg` - Resume the first suspended job.
- `bg` - Send the first suspended job to the background.

Try the following sequence of commands and keybindings:

```zsh
man ls
<ctrl-z>
nano ~/.zshrc
<ctrl-z>
```

Now you have 2 suspended jobs:

```
jobs
[1]  - suspended  man ls
[2]  - suspended  nano ~/.zshrc
```

If you type `fg` it should resume the most recent job, which is `nano`.

```zsh
fg
<ctrl-z>
```

If you want to resume the other job, look at it's ID in the `jobs` output. If we want to start job `[1]` instead, we would use `%1` as an argument to the `fg` command:

```zsh
fg %1
```

Similarly, if we wanted to kill job one, we could do:

```zsh
kill %1
```

If the program we have suspended to the background is a long running process, that we want to run asynchronously while we do other things in the shell, we can use the `bg` command to do that:

```zsh
# most recent job to background
bg

# job 1 to background
bg %1
```

## Using the Line Editor Effectively

TODO

For very long commands, or when you need to edit a complicated command from your history, use the line editor.

## Signals

- ctrl+c
- ctrl+z
- ctrl+s/q
- ctrl+\
- kill/pkill
