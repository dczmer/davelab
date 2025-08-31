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

### Test Operators

If the `if` statement is based on the exit code of a _command_, then how do you check other kinds of conditions, like if two strings are equal, one number is greater than another number, or if a string is empty?

For this, you need to use a "test operator". Basically, a special program that can compare one or more terms and translate some conditional logic into a return code that the `if` statement can use.

A test operator is written in the form of `[[ ]]` with your condition between the inner brackets.

If you want to compare two numbers, to see if one is greater:

```zsh
if [[ $x -gt 0 ]]; then
  echo "$x > 0"
fi
```

If you want to check if a string is empty or not, use `-z`:

```zsh
if [[ -z $x ]]; then
  echo "\$x is empty."
else
  echo "$x is a valid string."
fi
```

To see how a test works, you can try executing one directly in the shell. Use `echo $?` to print the return code of the previous command to see if the result was "true"/"false".

```zsh
[[ 1 -gt 0 ]]
echo $?
# 0  (remember, this means 'true')

[[ 1 -gt 2 ]]
echo $?
# 1  ('false' - non-zero return code)
```

{: .note }
Remember, these boolean conditions are based on the return code of the command. A return code of "0" means there was no error. A non-zero return code means there was an error (or 'failure'). So "true" = 0, and "false" = !0.

Here is a [nice reference of test operators](https://linuxhandbook.com/bash-test-operators/).

Or, run `man zshall` and search for "CONDITIONAL EXPRESSIONS" to see the list.

## The "case" Command

{: .todo }
TODO

## The "while" Command

{: .todo }
TODO

## The "for" Command

{: .todo }
TODO

- use `seq`
