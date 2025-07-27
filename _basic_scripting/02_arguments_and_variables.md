---
title: Arguments and Variables
lesson: 2
layout: default
---

# Variables

{: .todo }
Work in progress

```zsh
my_var="THIS IS MY VARIABLE"
```

- Use only alpha-numeric characters, and "_".
- No spaces around the "="!

Use `$VARIABLE` to get the value:

```zsh
echo $my_var
#  THIS IS MY VARIABLE

my_var="HELLO $my_var"

echo $my_var
#  HELLO THIS IS MY VARIABLE
```

## Interpolation

{: .todo }
Work in progress

## Capturing Command Output

{: .todo }
Work in progress

# Script Arguments

The parameters passed to your script are available as sequentially-numbered variables:

- `$1` is the first positional argument
- `$2` is the second positional argument
- `$3` is the third positional argument
- ...

{: .note }
Your script doesn't know that "`-x value`" means "option '`x`' with value '`value`'," it only understands each token as a separate positional argument. Keep your script simple, with positional arguments, or else you will need to use something like "`getopts`".
<br />
<br />
"man bash" or "man zshbuiltins" and search for "getopts"

If you want all of the arguments at once, the `$@` variable will contain them all in an "array" - a string where each value is separated by white-space.

The `$0` variable contains the name of the file that was executed. This can be useful when writing help output or examples that need to include the executable name, but you can know in advance where someone will copy or rename the script file.

## Default Values

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

# Reading from STDIN Like a UNIX Command

Your scripts can also read from `STDIN` using the `read` command. You won't need this very often, and we haven't covered loops yet, so don't worry too much about this one right now.

```zsh
#!/usr/bin/zsh
while read line
do
  echo "input: $line"
done
```

This would echo every line it reads from `STDIN`, and prepend "input: " before each line.
