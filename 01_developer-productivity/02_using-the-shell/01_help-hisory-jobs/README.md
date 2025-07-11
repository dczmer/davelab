# Finding Help

There are a lot of commands, and every command has options and required parameters. The commands you use every day will become muscle memory, but you will always need to look things up to find help or remember the options you need to use.

## `man` - The Manual Pages

The first place you should look is the manual pages. Most commands have manual pages that tell you all about the command, how it works, what are the parameters and options, known bugs, and often times they will have examples of how to use them.

To view the help for the `ls` command:

```zsh
man ls
```

![image](./images/man1.png)

You can move up and down in the document using the arrow keys (`↓`/`↑`) or `vim` keys `j`/`k`.

You can move down by one page with `space`.

You can search through the document by typing `/` and then entering your search term. For example, if you want to search to see what the `-X` option does, you would type `/-X`.

When you want to quit, press `q`.

Press `h` to view the help menu to see all the commands you can use.

## Command Help

If you know how to use the command but you need a quick reference, use the command's help option.

By convention, most commands and programs should have a help menu. You can usually see this by typing the command with either `-h` or `--help` as the parameter.

```zsh
ssh --help
```

Not every command has a help menu, but most do.

## Using `zsh` Autocomplete

If you completed the [`zsh` configuration](../../01_zsh-configuration/README.md) module, then you should have enabled and configured autocompletion.

If you already know the command but just can't remember the arguments or commands, you can often use this to just `<tab>` complete your way to typing out the command.

![image](./images/completion.png)

## Searching the Internet

I put this last because I think you should try to use the built-in help systems first.

In recent years, Google search results for have gone down in quality and it becomes harder and harder to find the information you are looking for under all of the ads and paid search results. But, for most queries, it should still find what you need on StackOverflow or other answers sites.

# Using your History

When you use the shell every day, most commands you need are already in your history. There are a few tricks you can use that will allow you to quickly retrieve specific commands from your history.

You can also rely on your history as a log of the sequence of commands you used to accomplish a task, that you need to repeat over and over.

## Reverse-Incremental Search

The first time I saw someone using this feature, I thought they must be a wizard. They were entering commands so fast, and using far fewer keystrokes than you'd need to type them all out.

But it's not really magic, he was just (very efficiently) searching through his history and entering commands that he had already previously run.

To use this feature, press `Ctrl+r` at the prompt.

![images](./images/risearch-1.png)

Now if you start typing, it will keep updating the command line with the best match, searching backwards through your history, for entries that contain your search term as a substring.

![image](./images/risearch2.png)

You can keep typing to refine your command, or you can use `Ctrl+r` and `Ctrl+Shift+r` to move forward and backwards through the other matches for your prompt.

If you want to run the command, hit `Enter`/`Return`.

If you want to cancel, hit `Ctrl+c`.

If you want to edit the current selection before running it, use the left or right arrow keys to move around.

## `zsh` Plugins

### `zsh-history-substring-search`

The [`zsh-history-substring-search` plugin](../../01_zsh-configuration/04_complete-setup) works like `Ctrl-r` but is a little more beginner friendly for most people.

To use it, just type any substring/part of the command you want to summon from the history, and then press the "up" arrow (`↑`).

If you want to cycle through more matches, you can cycle to the next match by pressing `↑` again, and you can go back with the "down" arrow (`↓`).

This is less powerful than `Ctrl-r` because, once you hit the arrow key, you can't continue typing to further refine your search. You have to cycle up/down, one entry at a time, based on the search string you already entered.

### `zsh-autosuggestions`

The [`zsh-autosuggestions` plugin](../../01_zsh-configuration/04_complete-setup) will show an in-line "autocomplete" placeholder, with the most recent command from your history that would complete what you have typed so far:

![images](./images/zsh-autosuggestions.png)

If you want to accept the suggestion, use the right arrow key (`→`).

## Replaying Sequences of Commands

I'm not sure if everyone would consider this good advice, but it's sometimes very convenient to just repeat a series of steps by cycling up through your command history by a fixed number of entries, and re-running each one in sequence.

For example, if you had to repeat this operation, over and over, to test your code:

1. Export your `mysql` database using `mysqldump` and save it to `/tmp`
2. Run a script to bootstrap a new copy of your database.
3. Run a script or command to populate the database according to some test criteria.
4. Export the `mysql` database again, to a second location.
5. `diff` the two database dumps.

A sequence of 5 commands, which you can repeat over and over without changing them.

After you finish running the sequence, and you want to repeat it, just hit the "up" arrow (`↑`) 5 times to retrieve the command for step one.

Once you run that command, it will now be at the bottom of your history list, which means that now step two is 5 commands back in your history. Press `↑` five more times and run it. Repeat until you've completed the sequence, hitting `↑` 5 times each time to run the next command.

This is convenient, and I do it all the time, but it may not be ideal:

- If you enter something in between commands, you can throw off the '5x' offset and mess up your sequence very easily.
- You might start moving too quickly and run the wrong commands out of sequence.
- Your history file might get truncated and you lose this history.

Once you've done this a few times, you should probably create a [simple script](../../03_basic-shell-scripting/README.md) instead.

## `pushd`/`popd`

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

## !? !!, etc.

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
