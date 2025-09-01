---
title: Arrays and Loops
lesson: 4
layout: default
---

- TC
{:toc}

# Arrays and Loops

{: .todo }
Cover arrays, zsh arrays, loops, and demo how to loop over the array of script variables to implement an argument parser using a case statement.

## Arrays

Most shells don't have actual "array" data types.

As we covered before, your shell is designed to process "lines of text". If there is a common delimiter between values in a line, like white-space or a comma, then many commands can recognize this as a "table of records".

So if you need an array, just make a 1-row "table" of data with a 1-line string.

```zsh
myarray="1 2 3 4 5 6 7 8 9 0"
```

Since " " (space) is the default separator, the shell can loop directly over the elements and you can use special operators to access the elements or manipulate this array data.

TODO:
- indexing
- checking length
- shift
- append/prepend with string interpolation
- slicing

### ZSH Arrays

zsh has actual array type but i just use the bash/string way

## For Loop

break, continue

## For ... In

loop over an array

## While / Until

The `while` command evaluates a condition, then executes the given list of commands and repeats until the initial condition is no longer "true."

```zsh
# run until the file doesn't exist
while [[ -e /tmp/test.txt ]]; do
  # print a message containing the first line of the file.
  echo "PROCESSING: $(tail -n1 /tmp/test.txt)" 

  # remove the first line of the file.
  sed -i /tmp/test.txt "1d" 

  # if the file is empty, delete it and end the loop
  if [[ ! -s /tmp/test.txt ]]; then
    rm /tmp/test.txt
  fi
done
```

Similarly, the `until` command exists to do the opposite: it will run the block of code as long as the supplied condition is _NOT_ "true."

### Using "while" + "case" to Implement a Menu

You can use "while" and "case" together to easily implement an interactive menu with validation.

```zsh
# in a script, double-quoted strings capture newlines.
# it's just a literal "\n" value.
menu="Select an option:
  ?) Help menu
  a) Option 'a'
  b) Option 'b'
  q) Quit"

echo "$menu"
while read -r "?Enter a selection: " answer; do
    case "$answer" in
        "")     echo "> Enter a selection." ;;
        '?')    echo "> This is the help menu." ;;
        'a')    echo "> This is option 'a'." ;;
        'b')    echo "> This is option 'b'." ;;
        'q')    exit 0 ;;
        *)      echo "> Unknown option $answer." ;;
    esac
    echo "$menu"
done
```

```
Select an option:
  ?) Help menu
  a) Option 'a'
  b) Option 'b'
  q) Quit
Enter a selection: z
> Unknown option z.
Enter a selection: ?
> This is the help menu.
Enter a selection: b
> This is option 'b'.
Enter a selection: a
> This is option 'a'.
Enter a selection: q
```


## Processing Script Arguments

You can use the `while` + `case` commands to process and validate script parameters.

The script arguments are in the array variable `$@`, and the individual parameters can be accessed with `$1`, `$2`, etc. (`$0` is the command name).

So an easy way to process script parameters, is to read `$1` then use `shift 1` to shift the array of arguments left, making the next argument the new `$1`. This lets us loop over each element in the array and the `while` command will automatically exit when there are no arguments left to process.

```zsh
while [[ "$1" != "" ]]; do
    case "$1" in
        -l)     echo "Supplied -l switch." ;;
        --beep) echo "beep" ;;
        *)      echo "Usage: [-l] [--beep]"; exit 1 ;;
    esac

    # shift to next parameter
    shift 1
done
```

If you need arguments, things get a little more complicated. You need to `shift` again to get the parameter for the selected argument. But if there are no arguments left, then `shift` will raise an error.

At this point, it's probably better to just use `getopts`.

### Getopts

There is a dedicated command just for processing script arguments, called `getopts`.

```zsh
while getopts ":lb:" opt; do
    case $opt in
        l)      echo "Supplied -l switch." ;;
        b)      echo "Supplied -b switch with value ${OPTARG}." ;;
        :)      echo "Missing value for ${OPTARG}."; exit 1 ;;
        *)      echo "Unknown ${opt}."; exit 1 ;;
    esac
done
```

The string `":lb:"` means:

- Leading `:` - If a required parameter to an argument is not specified, invoke the `:` case.
- `l` - Specifies a `-l` switch. Combine multiple switches into one string: `lmn` defines `-l`, `-n`, and `m` switches.
- `b:` - Specifies the `-b` switch, with a required argument (indicated by the trailing `:`).

Since we specified the leading `:`, `getopt` will resolve to `:` in the case we receive `-b` without the required parameter. Without the leading `:` it would just print a generic error message and exit.
