---
title: First Steps
lesson: 1
layout: default
---

- TC
{:toc}

# First Steps

## Shellcheck

Before you begin, you should [install ShellCheck](https://github.com/koalaman/shellcheck?tab=readme-ov-file#installing). It will lint and analyze your shell script for syntax issues and many common mistakes.

Bugs in you shell scripts can have some really weird, and hard to debug side-effects. Avoid the headache, always use `ShellCheck`.

To use `ShellCheck`, simply run the command and supply the target filename as an argument:

```zsh
shellcheck test.sh
#  In test.sh line 2:
#  var1="HELLO WORLD"
#  ^--^ SC2034 (warning): var1 appears unused. Verify use (or export if used externally).
#
#
#  In test.sh line 4:
#  ls /tmp/$var/images
#          ^--^ SC2154 (warning): var is referenced but not assigned (did you mean 'var1'?).
#          ^--^ SC2086 (info): Double quote to prevent globbing and word splitting.
#
#  Did you mean:
#  ls /tmp/"$var"/images
#
#  For more information:
#    https://www.shellcheck.net/wiki/SC2034 -- var1 appears unused. Verify use (...
#    https://www.shellcheck.net/wiki/SC2154 -- var is referenced but not assigne...
#    https://www.shellcheck.net/wiki/SC2086 -- Double quote to prevent globbing ...
#
#  shell returned 1
```

Not only will it warn you about any issues, it will also link you to a wiki page that explains the rule.

If possible, see if you can integrate it with your IDE or editor, so that it automatically analyzes your scripts while you edit.

## The "Shebang"

When you work from the command line, on a UNIX-like system, filename extensions don't really matter. You usually pass the name of a file to a command directly, instead of clicking on the file and the OS uses the extension to open the right program.

```zsh
# no need for file extension, like '.sh'
bash filename
```

But there is actually a way to make any text file 'executable', by using a special comment on the very first line, that tells the OS what program to run when this file is "executed."

```zsh
#!/usr/bin/bash
echo "Script will run with /usr/bin/bash."
```

You can use the command `which` to find the location of your shell's executable:

```zsh
which bash
#  /usr/bin/bash
```

To make the file actually "executable," you will need to modify the file and tell the operating system that this is an executable file:

```zsh
chmod +x filename
```

Now you can execute `filename` directly, and it will be run using the program from the "shebang" comment (either `zsh` or `bash` from the examples so far).

```zsh
# No longer need to execute `zsh` directly
./filename
```

If you put your executable shell script files in a common directory, like `~/bin`, then you can add that directory to your `$PATH` environment variable. This will make your scripts into global commands, which you can call from anywhere, without specifying the full path.

```zsh
export PATH="$PATH:~/bin"

# Now it's a global command
filename
```

Add that `export` command to your `~/.zshrc` file to make it permanent. See [ZSH Configuration module](./zsh_configuration) for more info.

You can also make other types of files executable, like `python` or `perl` scripts, for example. Just set the `-x` bit with `chmod` and set the shebang path to the `python` or `perl` executables.


## Formatting, White-Space

When entering multiple commands at the prompt, you use `;` (or `&&` or `||`) to separate multiple commands. In a script file, a newline also separates commands.

```zsh
# at the prompt
command1 ; command2 && command3
```

```zsh
#!/usr/bin/zsh
command1
command2 && command3
```

Note that the second line was actually a compound-command - the `&&` joins them into a single command, and you can's split a single command over multiple lines without escaping it.

To split a single command over multiple lines, use a `\` character directly before the newline:


```zsh
#!/usr/bin/zsh
command1
command2 \
  && command3
```

You can use the `\` to split the command anywhere there is white-space, it doesn't have to be before the `&&`. By convention, we would indent the following lines to show that this is a continuation of the previous line.

Otherwise, white-space between tokens do not really matter and are a matter of convention and personal taste.

## Exit Codes

The convention for UNIX commands, and shell scripts, is to use an "exit code" of 0 to indicate the program terminated normally, or a non-zero value to indicate there was some error.

The error code returned may have specific meanings for the command, or the value may indicate the number of errors, etc. The important part is that "success" is a "0", and "error" is a non-zero value.

To exit a shell script immediately, and return the specified argument as the return code, use the `exit` command:

```zsh
exit 1
```

If you let a script run until the end, and never call `exit`, then it will return an exit code of "0" automatically. If you call `exit` with no arguments, it will default to "0" as well.

## Export and Source

When you define a variable or a function in your script, it is local only to that script, and not accessible from the shell after the script has finished executing.

But if your script uses the `export` command to export a variable or function, and then you use the `source` command to evaluate it, then the exported variable or function becomes available in your shell session.

```zsh
#!/usr/bin/zsh
export MY_VARIABLE="HELLO WORLD"
```

```zsh
echo $MY_VARIABLE
#

source filename

echo $MY_VARIABLE
#  HELLO WORLD
```

## Debugging with "-e" and "-x"

Shell scripts are made of a sequence of shell commands. What happens when one command in the script fails? Do you expect the script to stop, or to keep on going?

If a command in the middle of your script fails, the error will be printed to `STDERR`, but the script will just keep on running from the next command. But you can change this behavior using `set -e`.

When you need to debug your shell script, it's useful to be able to see exactly what commands are running, so you can trace and verify execution.

- `set -e` will cause the script to immediately `exit` with a failing return code whenever a command in the script has an error, instead of just printing the error and continuing on with the script.
- `set -x` will print each command before it runs. This will be the command _after_ any and all expansion operations are performed. So this is useful for debugging, not only as a trace log of what commands run, but because it shows you the results of commands you have constructed using expansion or globs.

For both of these options, you can disable them again with `set +OPTION` (`set +e` / `set +x`). This means you can selectively turn them off and on at different portions of the script.

```zsh
# turn on `-x` to show debug trace
set -x

# `-e` is off by default.
# if this command fails, the script will keep running
mkdir -p /tmp/test123
touch /tmp/test123/{README.md,main.py}

# after this line, any failing commands cause the script to exit instead
set -e

wc -l /tmp/test123/main.py

# we can turn it off again, and failing commands will not exit the script again
set +e

touch /tmp/test123/test_main.py

# and now turn it on again to see an error
set -e

# i haven't installed py.test on this machine:
py.test /tmp/test123/test_main.py

# this will never run
echo "DONE"
```

And we would see a trace log, and that the script exited before printing the message "DONE":

```zsh
# +/tmp/test.sh:4> mkdir -p /tmp/test123
# +/tmp/test.sh:5> touch /tmp/test123/README.md /tmp/test123/main.py
# +/tmp/test.sh:7> set -e
# +/tmp/test.sh:9> wc -l /tmp/test123/main.py
# 0 /tmp/test123/main.py
# +/tmp/test.sh:11> set +e
# +/tmp/test.sh:13> touch /tmp/test123/test_main.py
# +/tmp/test.sh:15> set -e
# +/tmp/test.sh:17> py.test /tmp/test123/test_main.py
# /tmp/test.sh:17: command not found: py.test
```

---

[NEXT >>](./02_arguments_and_variables)
