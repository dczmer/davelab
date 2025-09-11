---
title: Useful Commands
layout: default
lesson: 4
---

{: .note }
Read through this once, then use it as a reference when you want to combine commands to do something later.

- TC
{:toc}

# Useful Commands

## Overview

This `linux` philosophy is that each tool should do one thing, and do that one thing well. Think of these commands as primitive building blocks that we can combine to write little programs that work on "lines of text" as data.

You don't have to master every command, you just need to what job they perform, so you know which command(s) to reach for when you have a problem.

A simplified overview of the process is that it's mostly about printing, filtering, and formatting lines of text and feeding the result into the next program, or just printing it out to the screen.

1. Put something onto an output stream.
2. Filter, translate, and format lines.
3. Redirect the output to the `stdin` stream of another command to do the next step.
4. Repeat steps 2 & 3 until you have done something useful.

Read along and try out each of the examples as you go. Try reading the `man` pages for each command and experimenting with the examples. In the next section, we'll use these to make some useful "one-liners".

## touch - I want to create a blank file

This is very basic, but if you just want to create a file so that it exists, use the `touch` command:

```zsh
touch /tmp/newfile.txt
```

That will create an empty file with the specified name and path.

## mkdir - I want to create a new directory

You can create a new directory with `mkdir`:

```zsh
mkdir test
```

To remove a directory, you have to supply the `-r` (recursive) flag to the `rm` command:

```zsh
rm test
# rm: cannot remove 'test': Is a directory

rm -r test
```

If you want to create a directory _AND_ it's parent directories at the same time, use the `-p` (parent) option:

```zsh
mkdir test/123/4
# mkdir: cannot create directory ‘test/123/4’: No such file or directory

# creates both the "123" and "4" directories at once:
mkdir -p test/123/4
```

## echo - I Want to Print a String

Print some text to the `stdout` stream:

```zsh
echo "Hello world!"
```

Example:

```zsh
echo "Hello world!" | wc -c
```

This will redirect the output to `wc` to count the number of characters in the string.

## cat - I Want to Print a File

Print the contents of a file to `stdout`.

```zsh
cat ./README.md
```

Example:

```zsh
cat ./README.md | head
```

Prints the contents of the `README.md` file, then redirects to `head` to print only the last few lines of text.

## printf - I Want to Print a Formatted String

This is like `printf/sprintf` from `C`. You can use this to interpolate and format a value into a format-string template. However, the behavior of this function varies from shell to shell. We'll be using the `zsh` version.

```zsh
printf 'Hello %s, you have $%05.2f in your account.\n' Frank 1.23456
```

This would print `Hello Frank, you have $01.23 in your account.`

- The `%s` is a place-holder for a string argument.
- `%f` is a place-holder for a floating-point number.
- `%05.2f` controls the formatting of the floating-point number:
    - `05` following the `%`, means the value should have a minimum width of 5 characters and should use a `0` to pad the front of the string.
    - `.2` controls formatting the decimal to show only two digits.

## wc - I Want to Count Lines/Entries/Words/Bytes

You can use `wc` to count the number of lines, characters, bytes, or calculate the maximum line width of a file or stream of text. It can take input from `stdin` or from a filename as a positional argument.

This would print the length of the longest line in the `README.md` file:

```zsh
wc -L README.md
```

This would print the number of lines of text from the input string (3):

```zsh
echo "1\n2\n\3\n" | wc -l
```

## less - I Want to Print One "Page" of Output at a Time

When you want to read and search through the output stream, you can pipe it to `less`. It will show one page/screen of data at a time, and prompt for you to press a key to show the next page. You can also search though the text using `/`.

```zsh
cat README.md | less

# since we're just reading a plain file, this makes more sense
less README.md
```

## head/tail - I Want to See Just The First/Last Few Lines

Sometimes you only care about the very end or the very beginning of the stream.

`head` will print the first few lines of a stream or file.

`tail` will print the last few lines of a stream or file.

```zsh
ls -t . | head -n1
```

This would show the most recently modified file or folder in the current directory. `ls -t` sorts by the most recent modification time, and `head -n1` shows the first line of that output.

You can also use `tail` to watch a file and print it's contents to the screen, as it's being written to.

```zsh
tail -f /path/to/logfile.log
```

## grep - I Want to Search for Text Or Filter Lines

Search for patterns in files or streams. You can use this to find files that contain text that matches a regular expression or to filter lines of output from a stream.

```zsh
grep -Ei 'TODO|NOTE' . -R
```

Case-insensitive search through all files under the current directory for `TODO` or `NOTE`.

- `-E` means use extended regex support. You might even want to `alias -- grep='grep -E'`.
- `-i` makes the search case-insensitive.
- `-R` means recursively search everything under the target.

You can also use `grep` to filter output from a stream:

```zsh
cat README.md | grep -E '^## '
```

This would print all of the level two headings from the markdown file.

You can also invert the search with `-v`, to print only the lines that do not match the pattern.

```zsh
cat README.md | grep -v pattern
```

This would print the markdown file but filter out every line that has the string "pattern" in it.

## find - I Want to Find Files or Folders

Search for files under a directory.

```zsh
find . -name '*.md`
```

This would find all of the `markdown` files under the current directory.

```zsh
find ~ -type d -maxdepth 1 -name '.*'
```

This would find all of the directories (`-type d`), under your home directory (`~`), up to a maximum depth of 1 (`-maxdepth 1`), who's names start with a '.' (hidden files).

{: .note }
The pattern is a `glob`, not a regular expression.

{: .note }
You should use single quotes around the pattern. Otherwise, the `*` would expand and be replaced with the names of all files in the current directory before the command runs.

## column - I Want to Format a List of Records Into a Table

```zsh
echo "1 2222 33\n4444 5 66\n7 8888 9" | column --table --table-columns=A,B,C
```

Would produce the following table:

```
A     B     C
1     2222  33
4444  5     66
7     8888  9
```

If you wanted to make this a CSV table, add `-o,` to use a comma as the separator.

Another useful feature of `column`, is that it can output the table of data as JSON.

```zsh
echo "a b c\nd e f\ng h i" | column --table-columns=col1,col2,col3 --json
#  {
#     "table": [
#        {
#           "col1": "a",
#           "col2": "b",
#           "col3": "c"
#        },{
#           "col1": "d",
#           "col2": "e",
#           "col3": "f"
#        },{
#           "col1": "g",
#           "col2": "h",
#           "col3": "i"
#        }
#     ]
#  }
```

## sort - I Want to Sort Lines

Sort lines of text.

```zsh
echo "3\n\1\n4\n2\n" | sort -r
```

Would sort the lines in reverse order (`-r`).

```zsh
echo "1 2222 33\n4444 5 66\n7 8888 9" | sort -k 2
```

Would sort the table by the values in the second column. By default, it will do a "C" / ASCII sort order. If not, ensure that you have set `LC_ALL=C` in your `~/.zshrc` file.

```
1 2222 33
4444 5 66
7 8888 9
```

If you wanted to sort by the second column numerically, use `-n`:

```zsh
echo "1 2222 33\n4444 5 66\n7 8888 9" | sort -nk 2
```

```
4444 5 66
1 2222 33
7 8888 9
```

## uniq - I Want to De-duplicate Lines

Filter duplicate lines out of the stream.

```zsh
echo "1\n2\n1\n3\n1\n4\n" | sort | uniq
```

{: .note }
`uniq` only filters duplicate lines if they are adjacent to each other. So you typically run the output through `sort` first.

## cut - I Want to Print Selected Parts of a String

You can use `cut` to print selected bytes, characters, or 'fields' from a line.

```zsh
echo "1 2 3 4" | cut -d' ' -f3
#  3
```

This would print the third 'field' of the input records, where ' ' (space) is the field separator (delimiter). This would print `3`.

## sed - I Want to Run a regex or Substitution Over Lines

> "A stream editor for filtering and transforming text."

`sed` is very powerful, but the main thing I use it for is running a regex substitution over every line in a stream.

This would replace all of the '-' characters with spaces:

```zsh
echo "1-2-3-4" | sed 's/-/ /g'
```

This would change each line from `Hello X`, to `Bye X`:

```zsh
echo "Hello A\nHello B\n" | sed 's/Hello \(.*\)/Bye \1/'
```

## xargs - I Want to Run a Command for Every Line

Execute a command against each line in a stream.

This would find all files under the current directory and run the `file` command on each one:

```zsh
find . -type f | xargs file
```

This will find all the markdown files under the current directory and then search each one for level-one headings:

```zsh
find . -name '*.md' | xargs grep -n '^# '
```

Sometimes you need to use the value to `xargs` as a positional argument, so you need a variable to use in your command. The `-I` switch defines the variable pattern, which will be replaced with the actual argument when it runs. A common convention is to use `{}` because you are unlikely to use that exact string in your final command.

```zsh
find . -name '*.md' | xargs -I{} printf "'%s'\n" {}
```

This would find all the markdown files and print their names in single quotes.

### xargs - I Want to Quickly Trim White-Space Padding From a String

Another use for `xargs` is to quickly strip leading/trailing white-space from a string. If you pipe something to `xargs` with no arguments, then it will simply strip the white-space and echo the value:

```zsh
echo '      hi     ' | xargs
# hi
```

## curl - I Want to Make an HTTP Request

You can use `curl` to make an HTTP request and print the response to `STDOUT`. You can filter and search the output to make a cheap unit test, and `curl` works really well for web-scraping scripts.

```zsh
curl https://kernel.org/category/releases.html
```

If you are working on a local development server, you may need to ignore certificate issues. You can use `-k` to skip certificate checking.

```zsh
curl -k https://localhost/insecure.html
```

You can use `curl` to `POST` a form:

```zsh
# HTML form-encoded
curl --request POST --data "name=dave" https://localhost/api

# JSON encoded (use "\" to break command over multiple lines)
curl --request POST \
    --header "Content-Type: application/json" \
    --data '{"name": "dave"}' \
    https://localhost/api
```

If you are testing an authorized webapp, you might need to include a session cookie with your request:

```zsh
curl -b "sessionid=1234" https://localhost/authorized
```

## awk - I Want to Filter, Format, or Translate Tables

"Pattern scanning and processing language."

`awk` is a programming language, but we'll cover just the basics of how I most often use it.

The "program" is supplied as a string argument with braces on each end `'{ ... }'`. The commands in this block will be executed on every line of the input stream.

You can print the value from a specific column by using one of the numerical index variables:

```zsh
echo "1 2 3 4 5" | awk '{ print $1 }'  # prints 1
echo "1 2 3 4 5" | awk '{ print $4 }'  # prints 4
echo "1 2 3 4 5" | awk '{ print $0 }'  # prints 1 2 3 4
```

The default field separator is ' ' (space), but you can specify a different delimiter with `-F`.

```zsh
echo "1,2,3,4,5" | awk -F, '{ print $3 }'  # prints 3
```

The `printf` function is useful for formatting values:

```zsh
echo "1,2,3,4,5" | awk -F, '{ printf "The number is %i\n", $2 }'  # "The number is 2"
```

Specify a pattern with `/PATTERN/` and it will apply the associated block on every line that matches the pattern.

```zsh
# prints "Apples=$12.00"
echo "Apple 10 1.2\nOrange 13 1.9" | awk '/Apple/ { printf "%s=$%.2f\n", $1, $2 * $3 }'
```

## jq - I Want to Filter, Format, or Translate JSON

`JSON` doesn't really fit into this 'lines of text' paradigm. However, you may want to read JSON into lines of records or write tabular data out to JSON. We'll mostly just cover basic operations and converting data to/from `JSON`.

### Basics

You can use `jq` to "pretty-format" `JSON` data:

```zsh
echo '{"a": 1, "b": [2, 3]}' | jq
# or
echo '{"a": 1, "b": [2, 3]}' | jq .
```

The `.` in the second example refers to the identity, or root of the object, which is the default argument if nothing is supplied.

You can use `.KEY` or `.[KEY]` to get the value of a specific key, or `.[N]` to get the value of an array element. And you can string them together to describe a path to the specific value(s) you want.

```zsh
echo '{"a": 1, "b": [2, 3]}' | jq '.a'  # prints "1"
echo '{"a": 1, "b": [2, 3]}' | jq '.b'  # prints "[2, 3]"
echo '{"a": 1, "b": [2, 3]}' | jq '.b[1]'  # prints "3"
echo '{"a": 1, "b": [2, 3]}' | jq '.a .b[1]'  # prints "1 3"
echo '{"key": [{"id": 1}, {"id": 2}]}' | jq '.key[] | .id + 100'  # prints "101 102"
```

### You can turn a table of data into an array of JSON data

([jq-table.data file](./jq-table.data))
```
col1 col2 col3
row1-1 row1-2 row1-3
row2-1 row2-2 row2-3
row3-1 row3-2 row3-3
```

```zsh
cat ./jq-table.data | jq -Rs 'rtrim | split("\n") | map(split(" "))'
# or without the table header row
cat ./jq-table.data | tail -n+2 | jq -Rs 'rtrim | split("\n") | map(split(" "))'
```

- `-R` allows you to pass raw data to `jq` without having to wrap every line in quotes.
- `-s` tells `jq` to read the entire thing at once, instead of expecting a stream of data.
- `rtrim` trims extra text from the end of the lines, prevents an empty array at the end.
- `split("\n")` splits by newlines, making one element for each "row".
- `map(split(" "))` - splits each "row" string into it's individual elements.

### Turn a table of data into a list of JSON objects:

If you want to turn the rows into objects, you need to `map` the results to an object constructor that maps the keys to the indexes of the corresponding columns.

`map({col1: .[0], col2: .[1], col3: .[1]})`

```zsh
cat ./jq-table.data \
    | jq -Rs 'rtrim | split("\n") | map(split(" ")) | map({col1: .[0], col2: .[1], col3: .[2]})'
# or without the table header row
cat ./jq-table.data | tail -n+2 \
    | jq -Rs 'rtrim | split("\n") | map(split(" ")) | map({col1: .[0], col2: .[1], col3: .[2]})'
```

### You can turn a JSON array into a table of data:

([jq-table.json file](./jq-table.json))
```
[
    [ "row1-1", "row1-2", "row1-3" ],
    [ "row2-1", "row2-2", "row2-3" ],
    [ "row3-1", "row3-2", "row3-3" ]
]
```

```zsh
cat ./jq-table.json | jq -r '["col1", "col2", "col3"], .[] | @tsv'
```

- `-r` writes 'raw' output, without extra quotes.
- `["col1", "col2", "col3"],` prepends a 'title row' to the table.
- `@tsv` is a filter that prints the `JSON` data as tab-separated-values.

### Turn list of JSON objects into lines of records:


([jq-object.json file](./jq-object.json))
```
[
  { "col1": "row1-1", "col2": "row1-2", "col3": "row1-3" },
  { "col1": "row2-1", "col2": "row2-2", "col3": "row2-3" },
  { "col1": "row3-1", "col2": "row3-2", "col3": "row3-3" }
]
```


```zsh
cat ./jq-object.json | jq -r '.[] | [ .col1, .col2, .col3 ] | @tsv'
```

---

[NEXT >>](./05_lab1)
