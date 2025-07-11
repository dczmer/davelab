# Finding Help

There are a lot of commands, and every command has options and required parameters. The commands you use every day will become muscle memory, but you will always need to look things up to find help or remember the options you need to use.

## `man` - The Manual Pages

The first place you should look is the manual pages. Most commands have manual pages that tell you all about the command, how it works, what are the parameters and options, known bugs, and often times they will have examples of how to use them.

To view the help for the `ls` command:

```zsh
man tmux
```

![image](./images/man1.png)

You can move up and down in the document using the arrow keys or `vim` keys `j`/`k`.

You can move down by one page with `space`.

You can search through the document by typing `/` and then entering your search term. For example, if you want to search to see what the `-X` option does, you would type `/-X`.

When you want to quit, press `q`.

Press `h` to view the help menu to see all the commands you can use.

## Command Help

If you know how to use the command but you need a quick reference, use the command's help option.

By convention, most commands and programs should have a help menu. You can usually see this by typing the command with either `-h` or `--help` as the parameter.

```zsh
ls --help
```

Not every command has a help menu, but most do.

## Using `zsh` Autocomplete

If you completed the [`zsh` configuration](../../01_zsh-configuration/README.md) module, then you should have enabled and configured autocompletion.

If you already know the command but just can't remember the arguments or commands, you can often use this to just `<tab>` complete your way to typing out the command.

![image](./images/completion.png)

## Searching the Internet

I put this last because I think you should try to use the built-in help systems first.

In recent years, Google search results for have gone down in quality and it becomes harder and harder to find the information you are looking for under all of the ads and paid search-results. But, for most queries, it should still find what you need on StackOverflow or other answers sites.

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

# `pushd`/`popd`

![image](./images/pushd.png)

you can put something in your prompt string `$(dirs -v | wc -l | xargs)`

# Jobs

# using the line editor effectively (with vim)


# !? !!, etc.
