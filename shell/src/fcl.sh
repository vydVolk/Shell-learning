#!/bin/sh

file_name="$1"
if [ -z "$file_name" ]
then
  echo "[arguments error]: Missing required parameters: file path."
  exit 1
fi

file_path="$(cd "$(dirname "$0")"; pwd)/$file_name"


if [ ! -r "$file_path" ]
then
  echo "[arguments error]: File $file_name not found."
  exit 1
fi

min_line="1"
max_line="$(sed -n '$=' $file_path)"
arg2="$2"
arg3="$3"
s_line="${arg2:-1}"
e_line="${arg3:-$max_line}"

if [ "$s_line" -gt "$e_line" ]
then
  echo "[arguments error]: Starting line number > ending line number."
  exit 1
elif [ "$s_line" -lt "$min_line" ]
then
  s_line=$min_line
elif [ "$e_line" -gt "$max_line" ]
then
  e_line=$max_line
fi

sed -n "$s_line,$e_line p" $file_path

exit 0

