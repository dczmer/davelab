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

## Test Operators

If the `if` statement is based on the exit code of a _command_, then how do you check other kinds of conditions, like if two strings are equal, one number is greater than another number, or if a string is empty?

For this, you need to use a "test operator". Basically, a special command that can compare one or more terms and translate some conditional logic into a return code that the `if` statement can use.

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
  echo "\$x is a valid string."
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

To see a list of all test operators, run `man zshall` and search for "CONDITIONAL EXPRESSIONS" to see the list.

Here are a few common ones:

| Operator | Description                        | Example                  |
|----------|------------------------------------|--------------------------|
| `-eq`    | Equals                             | `[[ $x -eq 0 ]]`         |
| `=`      | Equals (for strings)               | `[[ $x = "dave" ]]`      |
| `-ne`    | Not Equal                          | `[[ $? -ne 0 ]]`         |
| `!=`     | Not Equal (for strings)            | `[[ $x != "true" ]]`     |
| `-lt`    | Less Than                          | `[[ $x -lt 20 ]]`        |
| `-le`    | Less Than or Equal                 | `[[ $x -le 3 ]]`         |
| `-gt`    | Greater Than                       | `[[ $x -gt 0 ]]`         |
| `-ge`    | Greater Than or Equal              | `[[ $x -ge 10 ]]`        |
| `-z`     | The string is empty/null           | `[[ -z $empty ]]`        |
| `-n`     | The string is _not_ empty/null     | `[[ -n $string ]]`       |
| `-e`     | Check if file exists at given path | `[[ -e /tmp/test ]]`     |
| `-f`     | Check if the target is a file      | `[[ -f /tmp/test.txt ]]` |
| `-d`     | Check if the target is a directory | `[[ -d ~/source ]]`      |

## The "case" Command

The `case` statement allows you to evaluate a condition, and then supply a list of values to match on the result and the commands that should be executed for each match.

```zsh
case "$x" in
    "")     echo "Nothing specified." ;;
    hello)  echo "Hello world." ;;
    bye)    echo "Goodbye." ;;
    *)      echo "I didn't understand that." ;;
esac
```

In this example, we're evaluating the value of the `x` variable and matching it against a few specific target values. But you could substitute any command by using `"$( ... )` to capture it's output as the `case` pattern.

```zsh
case "$(head -n1 /tmp/logfile)" in
# ...
```

{: .note }
Note that we are wrapping the variable/command output in double-quotes so it doesn't break if the value contains spaces or other reserved symbols.

The resulting value from the `case` command will be checked against each pattern in the list.

- `""` Matches an empty string.
- `*` Matches anything. Put this at the very end to be the "default" clause.

The `;;` at the end is important. It signals the end of the section that handles one match. It also signals the `case` statement to stop scanning for additional matches.

If you need to write multiple commands in one match section, use `;` or `|`, etc. to separate commands:

```zsh
    "")     echo "Nothing specified."; exit 1 ;;
```

This would print the message and then exit with a non-zero return code, indicating that the command was not successful.

If you want the `case` statement to also execute the _next_ match block after this, you can end the block with a `;&`:

```zsh
case "$x" in
    hello)  echo "Hello world." ;&
    bye)    echo "Goodbye." ;;
esac
```

In this version, if `$x` resolves to "hello", then it will echo "Hello world." and then continue to print "Goodbye." also. If `$x` resolves to "bye", then it just prints "Goodbye."

And if you want the `case` statement to continue scanning for more matches after completing this block, use `;|` instead.

```zsh
case "$x" in
    h*)       echo "Starts with 'h'" ;|
    hello)    echo "Hello!" ;;
esac
```

If `$x` resolves to "hello", then it will print both messages.

## The "while" Command

{: .todo }
Describe the use of "while"/"until" and demonstrate how to use it along with "case" to implement a simple menu with validation.
