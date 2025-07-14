# Developer Productivity 02 - Expansion and Signals

## Overview

This section will cover "shell expansion", which allows you to pattern match file and directory paths as well as content from your history.

We'll also briefly cover some basic process management using `signals` and `jobs`.

## Expansion and "Globbing"

The concept of a "globbing" comes from the libC function, `glob` (though it actually pre-dates C).

A glob is a simple way of pattern matching file or directory paths in your commands.

`globs` are much more simple than a `regualr expression`, and you've probably already used this feature before.

- `*` matches zero or more characters.
- `?` matches exactly one character.
- `[]` specify a 'group' of characters to match, optionally negated with `!`.

Examples:

```zsh
# list all markdown files in this directory:
ls *.md

# look for log files in the form of `log-N.log`, for any (single-digit) value of `N`:
ls log-?.log

# search for any file named `the-letter-X.txt`, where `X` is an alpha character:
ls the-letter-[abcdefghijklmnopqrstuvwxyz].txt

# or, more simply:
ls the-letter-[[:alpha:]].txt

# or any version where the letter is not (`!`) "q"
ls the-letter-[\!q].txt
```

The [Wikipedia page](https://en.wikipedia.org/wiki/Glob_\(programming\)) is very short and has a good syntax table and some reference examples.

If "globbing" is a simple way to pattern match file and directory names that is built into the kernel, then "expansion" is like an advanced, shell-specific set of features to match more complex or dynamic selections.

When you enter a command, `zsh` will "expand" all the special directives in your command string and replace them with the actual values that match the patterns, BEFORE executing it as a shell command. This is like a "pre-processor" for your `C` compiler.

One common pattern that you may be familiar with is `**` which would expand to all sub-directories:

```zsh
# list all markdown files, anywhere under the current directory.
ls **/*.md
```

Another very useful globbing/expansion pattern is `{}`:

```zsh
# open three files at once, from a directory location i don't want to type out every time:
vim /very/long/path/to/my/project/{fileA,fileB,fileC}.py -O3
```

The argument `/very/log/path/to/my/project/{fileA,fileB,fileC}.py` _expands_ to:

```zsh
/very/log/path/to/my/project/fileA.py /very/log/path/to/my/project/fileB.py /very/log/path/to/my/project/fileC.py
```


### `!?` and `!!`

Besides expanding "path" patterns, your shell also supports "history" expansion.

Two that I use frequently are `!$` and `!!`. These two patterns will let you quickly substitute part of your previous command into your next command:

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

Try running `man zshall` and searching for `HISTORY EXPANSION` and `PATH EXPANSION` for

### String Interpolation, Quoting, and escaping

Shells make heavy use of string concatenation and interpolation.

Simply putting two strings next to each other in a command will concatenate them:

```zsh
echo "HELLO" "WORLD"

echo "HELLO ""WORLD"
```

A string that is surrounded in double-quotes (`"..."`) supports interpolation, and requires escaping of some special characters. A string surrounded in single-quotes does not support interpolation, and you don't have to escape anything (but you have to be careful if you want to use `'` in your string).

```zsh
# Print your prompt string in parentheses:
echo "MY PROMPT: ($PS1)"

# Run a command and include it in your string:
echo "Hello, $(whoami)!"

# Print the literal text "$PS1" (without interpolating the real value):
echo "MY PROMPT: (\$PS1)"

# or
echo 'MY PROMPT: ($PS1)'
```

Run `man zshall` and search for `QUOTING`

One important note:

> Expansion happens BEFORE the arguments are passed to the command!

Sometimes you want to pass a pattern or glob to another command, like `find`:

```zsh
# Say i have a directory with two files in it already:
ls .
  file1.txt
  file2.txt

# Now, I want to use `find` to locate all markdown files under `~/wiki`:
find ~/wiki -name *.txt
  find: file1.txt: unknown primary or operator
  find: file2.txt: unknown primary or operator
```

What happened here? Your shell expanded `*.txt` BEFORE passing it to the command!

```zsh
# this is not what we wanted:
find ~/wiki -name file1.txt file2.txt
```

The way to fix this is by quoting the `glob` pattern with single quotes.

```zsh
find ~/wiki -name '*.txt'
```

> NOTE: If you use double-quotes, then expansion still happens! Use single-quotes to avoid expansion, or else escape it with "\\\*.txt".

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

## Signals

TODO:

- ctrl+c
- ctrl+z
- ctrl+s/q
- ctrl+\
- kill/pkill

### `ps`, `kill`, `pkill`

TODO


---

[NEXT >>](../03_streams-and-pipes/README.md)
