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

## Expansion and Splitting

{: .todo }
Coming soon.

## Interpolation and Quote Types

{: .todo }
Coming soon.

- We covered Interpolation briefly in [section 02](./02_arguments_and_variables#interpolation), but we'll expand on it more here. That was not an intentional shell expansion pun.

## Using Strings

{: .todo }
Coming soon.

- Strings can span multiple lines (pressing return is just a literal `\n` character).
- Concatenate by just putting two strings next to each other: `$x=$1$2`, `echo "HELLO""WORLD"`.
- Get length with `#` variable expansion operator: `${#string}`.
- Finding substrings: `expr index "$text" "$word"`.
- Slice like `${string:POSITION:LENGTH}` (or just `${string:POSITION}` and it will go to the end of the string).
- Replace substrings with `${string/PATTERN/REPLACE}` regex expansion (`string//PATTTERN/REPLACE`) to replace all.
- Delete substrings `${string/PATTERN}` (use double-slashes to remove all occurrences)
- Uppercase with `${string^^}`, lowercase with `${string,,}` (does not work in zsh)

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
