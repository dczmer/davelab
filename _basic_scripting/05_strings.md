---
title: (TODO) Strings and Arithmetic
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

Delete a substring is very similar, just omit the "PATTERN" part:

```zsh
echo "${PATH/\/bin}"
#  :/usr/bin:/usr/share/bin:/home/dave/bin
echo "${PATH//\/bin}"
#  :/usr:/usr/share:/home/dave
```

# Arithmetic

## Integer Arithmetic Using "expr"

{: .todo }
Coming soon.

## Integer Arithmetic Using "$(( ... ))"

{: .todo }
Coming soon.

## Using "bc"

{: .todo }
Coming soon.

---

[NEXT >>](./06_lab1)
