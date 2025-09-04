---
title: (TODO) Strings
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

## Using Strings

{: .todo }
Coming soon.


<!--
- Strings can span multiple lines (pressing return is just a literal '\n' character)
- Concat by just putting two strings next to each other: `$x=$1$2`, `echo "HELLO""WORLD"`
- Get length with `#` variable expansion operator: `${#string}`
- Finding substrings: `expr index "$text" "$word"` (better than echo|sed and capture i was doing)
- Slice like `${string:POSITION:LENGTH}` or just `${string:POSITION}` and it will go to the end of the string
- Replace substrings with `${string/PATTERN/REPLACE}` regex expansion
- Delete substrings `${string/PATTERN}` (use double-slashes to remove all occurrences)
- To uppercase: `${string^}`
- To lowercase: `${string,}`
- Chanage only certain characters to upper `${string^^[abc]}`
-->



---

[NEXT >>](./06_arithmetic)
