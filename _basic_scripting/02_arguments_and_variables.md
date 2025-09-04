---
title: Arguments and Variables
lesson: 2
layout: default
---

- TC
{:toc}

# Arguments and Variables

## Variables

You can define a variable using `=`:

```zsh
my_var="THIS IS MY VARIABLE"
```

- Variable names use alpha-numeric characters and underscore (`_`).
- No spaces around the equals (`=`).
- By convention, `lowercase` for script variables, `UPPERCASE` for global variables.

When you want to use a variable, after it has been assigned, you have to prefix the variable name with `$` (example: `$my_var`).

### Interpolation

Shell scripts and commands work with lines of text. That means, under-the-hood, all of your variables are strings. And if everything is a string, the we can use features like string concatenation (joining two strings together), and interpolation (printing one string inside of another string).

```zsh
echo $my_var
#  THIS IS MY VARIABLE

# `interpolate` the current value of `$my_var` into a new string.
my_var="HELLO $my_var"

echo $my_var
#  HELLO THIS IS MY VARIABLE

# `concatenate` two strings just by putting them next to each other.
echo "MESSAGE: " $my_var
#  MESSAGE: HELLO THIS IS MY VARIABLE
```

{: .note }
Interpolation only works when using double-quoted strings. If you use single-quotes, then there is no 'magic' allowed inside of the string - it is purely a literal value.

### Capturing Command Output

If you want to run a command and capture it's output into a string variable, use the `$(...)` operator.

```zsh
# capture the STDOUT of the command `ls -al /tmp` into variable `$output_string`
ouput_string="$(ls -al /tmp)"
```

Be sure to wrap it in double-quotes.

This only captures the `STDOUT` stream. If you want to also capture the `STDERR` into the variable, just redirect it to `STDERR`:

```zsh
# capture the STDOUT and STDERR of the command `ls -al /tmp` into variable `$output_string`
ouput_string="$(ls -al /tmp 2>&1)"
```

## Script Arguments

The parameters passed to your script are available as sequentially-numbered variables:

- `$1` is the first positional argument
- `$2` is the second positional argument
- `$3` is the third positional argument
- ...

{: .note }
Your script doesn't know that "`-x value`" means "option '`x`' with value '`value`'," it only understands each token as a separate positional argument. Keep your script simple, with positional arguments, or else you will need to use something like "`getopts`".
<br />
<br />
See [the later section on "getopt"](../basic_scripting/04_arrays_and_loops#getopts) for details.

If you want all of the arguments at once, the `$@` variable will contain them all in an "array" - a string where each value is separated by white-space.

The `$0` variable contains the name of the file that was executed. This can be useful when writing help output or examples that need to include the executable name, but you can know in advance where someone will copy or rename the script file.

### Default Values

You can read the script argument variables (or any other environment variable from the shell when you executed the script) while supplying a default variable, to be used if the argument (or external variable) does not exist.

```zsh
ARG1="${1:-default1}"
ARG2="${2:-default2}"
```

The `${}` syntax allows you to expand and operate on variables.

- `1` - This is `$1`, or `${1}` (same value).
- `:-` - This means the value following the `-` is the default value to use if the variable before `:` does not exist.
- `default1` - This is the default value to use.

If this script was called with no arguments, then `ARG1` would be "default1" and `ARG2` would be "default2."

## Finding the Path of the Running Script

Frequently, you will want to write scripts that work on files that we expect to be at a location relative to the script file. For example, scripts that are typically included with a software project source code may need to know exactly how to reach the important files that it needs to work on.

```text
-+ project_root/
 |-- my_script.sh    # <-- this script needs to run over every .py file in the project
 |-- main.py
 |-+ lib/
 | |- server.py
 | |- utilities.py
 |-+ test/
   |- test_server.py
   |- test_utilities.py
```

If you only use absolute file paths, then you would have to prescribe that everyone working on the project installs the source code at the exact same path on their system. But, if you want to be able to find the other files under the same directory without hard-coding a path, you need to use relative paths.

```zsh
# absolute path
wc -l /hard-coded/path/to/project/lib/server.py

# relative path (from top-level directory of the project folder)
wc -l ./lib/server.py
```

So we could write `my_script.sh` to use relative paths, like `./lib` or `./test`.

```zsh
# relative paths work well, when we run from the directory containing the script file
sh ./my_script.sh
```

But if we ever try to call the script from a different working directory, then the relative files, like `./lib`, are treated as relative the directory we're running from.

```zsh
# change to /tmp, away from where the script is located
cd /tmp

# this fails because now it considers `./lib` to mean `/tmp/lib` :(
sh /path/to/project/my_script.sh
```

To find the working directory, we need to do a little processing of the shell script arguments. We'll walk through how it works, but you can probably just save this one to your notes or make a snippet to apply it when you need it.

### The Easy Way, with ZSH

If you don't care about "portability" and you are only writing a script for yourself to run, then `zsh` makes this very easy:

```zsh
ABS_PATH="${0:a}"
```

This is still `$0`, the name of the current script, but we're applying an expansion operation on the value to get the absolute path. We'll cover more of the variables and how you can modify them with `${VAR}` syntax in the next section.

- `$0` is still the (relative) path of the current script file.
- `${VAR}` syntax allows you to do operations on the variable, like perform variable expansion or provide default values. `$0` and `${0}` are the same thing.
- `:a` is a special modifier that says to treat `$0` as a relative path name, and replace it with it's absolute path.
- And we always wrap the value in double-quotes, so it does not break on white-space characters. `shellcheck` will make sure you remember this.

### The "Portable" Way

Here is the "portable" way to do it (will work on most shells):

```zsh
# get the name and (relative) path of the script (script argument 0)
DIR_NAME="$(dirname -- "$0")"

# get the absolute path of DIR_NAME
ABS_PATH="$(cd $DIR_NAME &>/dev/null && pwd)"
```

- Using `$(...)` to capture a variable.
- Wrap `$(...)` commands with double-quotes to avoid issues with white-space in directory names.
- `$0` is the name of the script file that is executing.
- `dirname` is a shell function that returns just the directory part of a file path.
- `cd $DIR_NAME &>/dev/null` changes the working directory to the target script directory.
  - This will only change the directory for the commands inside of this `$(...)` section, and does not affect the rest of the script.
  - `&>/dev/null` Redirects `STDOUT` and `STDERR` (all output) to the null device, suppressing any output from this command.
- `&& pwd` prints the current working directory as soon as we change to the script directory. The `pwd` output will be the absolute path to the directory.

So that is the "portable" way to do it. It is a little strange at first, but not really that bad once you know what it does.

## Reading from STDIN Like a UNIX Command

Your scripts can also read from `STDIN` using the `read` command. You might not need this very often for simple scripts, and we haven't covered loops yet, so don't worry too much about this one right now.

```zsh
#!/usr/bin/zsh
while read line
do
  echo "input: $line"
done
```

This would echo every line it reads from `STDIN`, and prepend "input: " before each line.

---

[NEXT >>](./03_conditionals)
