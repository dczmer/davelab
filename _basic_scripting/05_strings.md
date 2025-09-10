---
title: Strings and Arithmetic
lesson: 5
layout: default
---

- TC
{:toc}

# Strings

```zsh
string="LOOK AT ME! I'M ALL STRINGY!"

capture="$(echo 'this string is from another command')"
```

Is it an odd choice to cover strings at the end of the module, after functions, arrays, and conditional logic? You've been using strings all this time, so this section is just going to formally explain a few things and show you a few useful tricks.

## Interpolation and Quote Types

We covered Interpolation briefly in [section 02](./02_arguments_and_variables#interpolation), but we'll expand on it more here. That was not an intentional shell-expansion pun.

Double-quoted strings work kind of like format strings you may have used in `python`, `javascript`, or other programming languages. You can embed variables and other expressions directly inside of the string, and they will be replaced with the real values.

```zsh
hello="hello"
world="world"

echo "$hello $world $(date +%T)"
#  hello world 18:48:20
```

Use a backslash (`\`) to escape the "`$`" or other special symbols or glob characters:

```zsh
echo "\$hello \$world \$(date +%T)"
#  $hello $world $(date +%T)
```

Single-quoted strings won't evaluate variables and expressions, or special characters like newline. A single-quoted string is just a raw string literal.

```zsh
echo '$hello $world $(date +%T)'
#  $hello $world $(date +%T)
```

## Using Strings

You can make multi-line strings with double quotes. A newline is just treated as a literal "`\n`" character in the string.

```zsh
moolti_line="Line 1
Line 2
Line 3
"
echo "$moolti_line"
#  Line 1
#  Line 2
#  Line 3
```

To concatenate two strings in one expression, just put them directly together and they will join:

```zsh
$x=$1$2

echo "HELLO""WORLD"
```

To get the length of a string, use the "`#`" expansion operator:

```zsh
string="HELLO"
echo "${#string}"
#  5
```

Slicing a string or extracting a substring with `${VAR:START:LENGTH}` or `${VAR:START}` syntax:

```zsh
string="HELLO WORLD"
echo "${string:3}"
#  LO WORLD
echo "${string:6:5}"
#  WORLD
```

Force a string to uppercase (`^^`) or lowercase (`,,`):

```zsh
string="Hello World"
echo "${string^^}"
#  HELLO WORLD
echo "${string,,}"
#  hello world
```

Replace a substring with `${VAR/PATTERN/REPLACE}`:

```zsh
echo "$PATH"
#  /bin:/usr/bin:/usr/share/bin:/home/dave/bin
echo "${PATH/bin/beep}"
#  /beep:/usr/bin:/usr/share/bin:/home/dave/bin
```

TO replace every instance of the substring, use two slashes before the pattern:

```zsh
echo "${PATH//bin/beep}"
#  /beep:/usr/beep:/usr/share/beep:/home/dave/beep
```

Delete a substring is very similar, just omit the "REPLACE" part:

```zsh
echo "${PATH/\/bin}"
#  :/usr/bin:/usr/share/bin:/home/dave/bin
echo "${PATH//\/bin}"
#  :/usr:/usr/share:/home/dave
```

# Arithmetic

You can do simple integer math with `bash` but, when you need floating-point math, you will need to use another program or write your script with another programming language, like `perl` or `python`, for example.

## Integer Arithmetic Using "$(( ... ))"

The built-in arithmetic operations provided by `bash` require use of the `$(( ... ))` operator. Statements inside of these double-parentheses are treated as arithmetic statements, and do not follow the normal expansion and globbing rules.

```zsh
five="$((1 + 6 - 1))"
echo "$five"
#  5
```

Inside of the parentheses, a "`*`" character means "multiplication" and it is not treated as a glob operator, so it requires no extra escaping or quoting:

```zsh
two="2"
five=5
echo "$(($two * $five))"
#  10
```

The following built-in operations are available:

- (`-`) Subtraction
- (`+`) Addition
- (`*`) Multiplication
- (`/`) Integer division
- (`%`) Modulus
- (`**`) Exponents

You ca also use this operator in an `if` statement, where you don't need the "`$`":

```zsh
if ((1 + 2 > 1)); then echo 'true'; fi
#  true
```

## Integer Arithmetic Using "expr"

You can also do simple math (and logical evaluation) with the `expr` command:

```zsh
echo "$(expr 2 '*' 5)"
#  10
```

{: .note }
You have to quote (with single-quotes) or escape the "*" with this command.
The "expr" command is just a normal command, which means that it's arguments are subject to expansion and globbing.

You can do the following (and more) operations using `expr`:

- (`-`) Subtraction
- (`+`) Addition
- (`*`) Multiplication
- (`/`) Integer division
- (`%`) Modulus
- Comparison 'tests': `<`, `>=`, `!=`, ...
- Logical operators: `&`, `|`, ...

See `man expr` to see everything you can do.

## Using "bc"

The `bc` command is one way you can do floating-point math (and a lot of other math things) in your shell commands.

It's more like an interpreter for a scientific math language. Luckily, you don't have to learn a new language to use it. You can just write a simple math statement in a string and evaluate it with `bc -l` (`-l` uses the standard math library).

```zsh
echo "123 * 345" | bc -l
#  42435

echo "5 / 4" | bc -l
#  1.25000000000000000000
```

If you want to control the precision of your output, you have to set the global `scale` variable.

```zsh
# custom precision
echo "scale=3; 5 / 4" | bc -l
#  1.250
```

---

[NEXT >>](./06_lab1)
