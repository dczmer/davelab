# 02 Using the Shell - Streams and Pipes

## Overview

Programs can send their output to (and receive their input from) another program or another file.

If you combine multiple commands this way, you can write little programs in your shell that work on _lines of text_.

These lines of text are typically filtered, pattern-matched, transformed and then printed or sent as input into yet another program.

If your lines of text are separated by a common delimiter character, then shell commands can understand this and treat the data as a _list of records_ of tabular data.

- Generate, translate, filter, and transform text:
    * This could include everything from building reports to writing a command that generates another, very complicated command.
- _Process lists of records_ of tabular data

## I/O Streams

I think the term "stream" is a pretty good way to describe the concept. Data flows from in one direction and it can be split, combined, or diverted in various ways with a little bit of plumbing.

TODO: diagram

On a Unix-based system (that includes Mac/Darwin and Linux), the kernel treats any data source or device the same way it treats a normal file. This just means that there is a consistent interface for reading, seeking, opening, closing, writing to all of these data sources.

The reason I bring this up is because it will help you understand what streams are if you think of them as files. Files that don't actually exist anywhere on disk and disappear when the command sequence is complete.

Multiple programs can keep a file open and read/write to it at the same time. One program can read the contents of a file and, when it gets to the end, wait a while and then check to see if more data has been added to the end of the file by another program.

### STDIN

When a program reads from `STDIN` ("standard input") stream, it will read any information in that stream and then wait for more data to be written. When it detects new data, it will process that, then wait again (until it receives a special "end of file" sequence).

TODO: diagram

In your interactive shell, `STDIN` defaults to the characters you type from your keyboard, like editing a file in a text editor. But, usually, we write another command to produce specific output and "pipe" that to the next program, to become that program's `STDIN` stream. This is like writing a program to produce a very specific input "file" for the next program to read.

### STDOUT

You may have guessed by now, `STDOUT` is an _output_ stream, and it goes to your monitor, by default. The output of a program is written to this "file" and, if we "pipe" it to another command, this program's `STDOUT` is also the next program's `STDIN`. We can combine programs this way into chains or "pipelines" to do complex tasks.

The first input starts with my keyboard, then the output of each command becomes the input of each subsequent command, and then the last output stream goes to my monitor for display.

TODO: diagram

### STDERR

The other important stream to know is `STDERR`, which is the "error" output stream. This is typically where error or warning text is printed by a program.

This stream also goes to your monitor, so it will look like it's part of the `STDOUT` data. But they are actually two different streams and you can point them off in different directions.

```zsh
# "2" is the ID or "file descriptor" for STDERR
rm /tmp/this-file-does-not-exist 2>/dev/null
```


The example above would try to remove the file and, if the file didn't exist or there was some problem, would send the error output to the "null device" (basically send it to nowhere). The `STDOUT` would still go to the screen, but the `STDERR` would not be printed.


## Redirection

- '>', '>>'


## Pipes

- pipes
- tee

### Named Pipes

- named pipes

---

[NEXT >>](../04_commands/README.md)
