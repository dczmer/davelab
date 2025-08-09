---
title: (TODO) Conditionals and Loops
lesson: 3
layout: default
---

# Conditionals and Loops

- TC
{:toc}

## The "if" Command

To do a simple "if/else" block on a boolean conditional statement, we use the `if` command. You may be able to tell from the syntax that it _is_ a command and not a built-in "language feature."

`if CONDITION; then COMMAND; fi`

- The `if` command accepts a boolean parameter to evaluate.
- The `then` command accepts another command as a parameter, to be executed if the boolean evaluates to `true`.
- The `fi` command signals the end of the `if/else` state.

In script files, it's usually written out like this:

```zsh
if CONDITION; then
  COMMAND
fi
```

The "boolean parameter" is actually another command to run, and the return code of that command is the boolean value that is evaluated. If the command ran without error, and returned a code of "0", then the statement is "true" and the `then` block will execute.

{: .note }
So the purpose of an `if` statement is to conditionally execute a command based on whether another command succeeds or fails.

You can also use `else` and `elif` clauses:

```zsh
if ls /tmp/folder1; then
  echo "Found /tmp/folder1"
elif /tmp/folder2; then
  echo "Found /tmp/folder2"
else
  echo "Did not find either folder1 or folder2"
fi
```

## The "case" Command

{: .todo }
TODO

## Conditional "Tests"

{: .todo }
TODO

- use `$RANDOM`

## The "while" Command

{: .todo }
TODO

## The "for" Command

{: .todo }
TODO

- use `seq`
