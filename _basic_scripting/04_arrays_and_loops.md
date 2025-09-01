---
title: Arrays and Loops
lesson: 4
layout: default
---

- TC
{:toc}

# Arrays and Loops

## Arrays

Arrays aren't really a standard shell feature, but most modern shells have some implementation. Bash arrays are probably the most appropriate implementation to cover here, because `zsh` fully supports it and because you will probably want/need to write scripts for servers or development machines that have `bash`.

{: .note }
We're intentionally using "bash" array syntax here, not "zsh" arrays. They work differently but "zsh" supports both systems.

### Declaring an Array

There are two ways to declare an array:

```zsh
# 1. Declare array-type variable
declare -a array1

# 2. Assign array literal
array2=(a b c d e)
```

You can also create an associative array (or dictionary/map):

```zsh
declare -A associative

associative2=(["key"]="value")
```

### Indexing and Subscripting

Accessing elements in arrays works much like you'd expect:

```zsh
echo "$array2[0]"
# a

# negative values count from the end
echo "$array2[-1]:
# e

echo "$associative['key1']"
# value1
```

You can get all values in an array using `[@]` subscript.

```zsh
echo "${array2[@]}"
# a b c d e
```

Use variable expansion operator `#`, along with the `[@]` subscript, to print the length of an array:

```zsh
echo "${#array2[@]}"
# 5
```

You can print the keys with expansion operator `!` and the `[@]` subscript:

```zsh
echo "${!array2[@]}"
# 0 1 2 3 4

echo "${!associative[@]}"
# key1 key2 key3
```

You can also "slice" arrays by specifying a starting index, and the length of the slice:

```zsh
echo "${array[@]:3:2}"
# d e

# note the space before '-' is required
echo "${array[@]: -3:2}"
# c d
```

### Setting Values

You can assign a value directly using a subscript:

```zsh
array1[0]="a"
array1[1]="b"

associative["key1"]="value1"
```

And you can append elements using `+=`:

```zsh
array1+=("c")
# can append multiple elements
array1+=("d" "e")

associative+=(["key2"]="value2" ["key3"]="value3")
```

## For ... In

The `for ... in` command will loop over all of the elements of an array:

```zsh
for element in "${array2[@]}"; do
    echo "$element"
done
```

You can loop over the indexes or keys of an associative array:

```zsh
for key in "${!associative[@]}"; do
    echo "$key"
done
```

The `for ... in` loop works over other `[LIST]` types too. A `[LIST]` is a series of strings, separated by spaces.

Use brace-expansion to make a sequence of numbers:

```zsh
for i in {1..10}; do
    echo "$i"
done
```

Use file globs to make a sequence of entries:

```zsh
for path in /tmp/*; do
    echo "$path"
done
```

## For Loop

You can also write a standard `c`-style `for` loop:

```zsh
for ((i=0; i < 10; i++)); do
    echo "i=${i}"
done
```

We haven't covered `((...))` operator yet, but this allows arithmetic operations on the values inside the parentheses.

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

---

[NEXT >>](./05_functions)
