---
title: (WIP) Streams and Pipes
layout: default
lesson: 3
---
- TC
{:toc}

# Streams and Pipes

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

{: .todo }
crappy drawing of a 'stream'

On a Unix-based system (that includes Mac/Darwin and Linux), the kernel treats any data source or device the same way it treats a normal file. This just means that there is a consistent interface for reading, seeking, opening, closing, writing to all of these data sources.

The reason I bring this up is because it will help you understand what streams are if you think of them as files. Files that don't actually exist anywhere on disk and disappear when the command sequence is complete.

Multiple programs can keep a file open and read/write to it at the same time. One program can read the contents of a file and, when it gets to the end, wait a while and then check to see if more data has been added to the end of the file by another program.

### STDIN

When a program reads from `STDIN` ("standard input") stream, it will read any information in that stream and then wait for more data to be written. When it detects new data, it will process that, then wait again (until it receives a special "end of file" sequence).

{% mermaid %}
---
config:
    theme: dark
---
flowchart LR
    Start -->|Read STDIN| W(Wait)
    W --> IN{New lines?}
    IN --> Y(YES) --> Start
    IN --> N(NO) --> W
{% endmermaid %}

In your interactive shell, `STDIN` defaults to the characters you type from your keyboard, like editing a file in a text editor. But, usually, we write another command to produce specific output and "pipe" that to the next program, to become that program's `STDIN` stream. This is like writing a program to produce a very specific input "file" for the next program to read.

### STDOUT

You may have guessed by now, `STDOUT` is an _output_ stream, and it goes to your monitor by default. The output of a program is written to this "file" and, if we "pipe" it to another command, this program's `STDOUT` is also the next program's `STDIN`. We can combine programs this way into chains or "pipelines" to do complex tasks.

The first input starts with my keyboard, then the output of each command becomes the input of each subsequent command, and then the last output stream goes to my monitor for display.

{% mermaid %}
---
config:
    theme: dark
---
flowchart LR
    keyboard --> cmd1 --> cmd2 --> cmd3 --> screen
{% endmermaid %}

### STDERR

The other important stream to know is `STDERR`, which is the "error" output stream. This is typically where error or warning text is printed by a program.

This stream also goes to your monitor, so it will look like it's part of the `STDOUT` data. But they are actually two different streams and you can point them off in different directions.

```zsh
# "2" is the ID or "file descriptor" for STDERR
rm /tmp/this-file-does-not-exist 2>/dev/null
```


The example above would try to remove the file and, if the file didn't exist or there was some problem, would send the error output to the "null device" (basically send it to nowhere). The `STDOUT` would still go to the screen, but the `STDERR` would not be printed.


## Redirection

You can "redirect" `STDOUT` to another destination, like a file or another output stream. You can also "redirect" input to `STDIN` from another source, besides your keyboard.

You can redirect output to a file on disk.

```zsh
# create or overwrite /tmp/hi.txt
echo "HI" > /tmp/hi.txt

# append to existing /tmp/hi.txt
echo "HELLO" >> /tmp/hi.txt
```

A single "`>`" will send the output to the file `/tmp/hi.txt`, creating the file if it does not exist, or overwriting it if it does exist.

Using "`>>`" will _append_ the output to the existing file, instead of overwriting it.

If you redirect an output stream to `/dev/null`, it will suppress that output. You might do this, for example, if you want to run a command that might fail and you don't want the `STDERR` output if it does.

```zsh
ls ~/tmp /doesnotexist
#  ls: cannot access '/doesnotexist': No such file or directory
#  ~/tmp:
#  file1
#  file2
#  ...

ls ~/tmp /doesnotexist 2>/dev/null
#  ~/tmp:
#  file1
#  file2
#  ...
```

You can redirect the output from one stream to another output stream as well. You might want to do this if you want to treat `STDERR` like part of `STDIN`, so you can filter for errors or regular output with one command.

```zsh
# this time, the error message is on STDOUT so grep can match it
ls ~/tmp /doesnotexist 2>&1 | grep 'No such file'
#  ls: cannot access '/doesnotexist': No such file or directory
```

You can also redirect output to the default `STDIN` and another program can read that:

```zsh
cat ~/tmp/hi.txt
#  HI
#  HELLO

# sed reads from STDIN
sed 's/HI/HELLO/' <(cat ~/tmp/hi.txt)
#  HELLO
#  HELLO

# you can redirect input AND output
sed 's/HI/HELLO/' <(cat ~/tmp/hi.txt) > ~/tmp/hello.txt
```

### tee

When you redirect your output to a file, you don't see it on your screen. If you want to see the output on your screen AND redirect it to a file, use the `tee` command.

```zsh
tail -f /var/log/nginx/access.log | grep mypage.html | tee /tmp/mypage.log
```
In this example, we're "tailing" a log file - watching it for changes and printing them to the screen as soon as something new is written to the file.

The `grep` command filters the live log output, so that it only prints lines that mention `mypage.html`.

Then `tee` will redirect the output to the specified file, `/tmp/mypage.log`, while also printing it to your screen (`STDOUT`).

## Pipes

With pipes, you directly connect two programs at opposite ends of a shared data stream. One program is the producer, which writes it's output directly to the stream. The other program is the consumer, which reads it's input directly from the stream.

{: .note }
NOTE TO SELF: Do NOT make a human centipede reference here. It's a perfect analogy, but NSFW. Remember to delete this before publishing.

If you've read the other sections in this module, you've already seen plenty of examples of this concept in other examples.

Use `|` to pipe to programs together. The first program (left of `|`) will write to its output stream, and the second program will read that same stream as its input stream. As the first program writes more lines of data, the second program will process it and pass through to its own output stream.


```zsh
# - find all markdown files under the current directory
# - filter for files that start with '_' (output from find has leading "./")
# - for each filename, run wc-l to show number of lines
# - sort, in reverse order, so longest files are on top
find . -name '*.md' | grep -E '^./_' | xargs wc -l | sort -r
```

<p class="note">
Normally, only the STDOUT of a program gets piped to the next one. If you want to send STDERR along with it, you can use "<code>|&</code>" to combine both output streams into one.
</p>

### Try it Out

Let's write a command by building it up incrementally, and examining the output at each stage.

{: .todo }
Walk through a multi-part command, building it up one piece at a time.

```zsh
#
```

---

[NEXT >>](./04_commands)
