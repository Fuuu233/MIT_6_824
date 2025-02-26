#!/bin/bash
go run ii.go master sequential pg-*.txt

# cause sort to be case sensitive.
# on Ubuntu (Athena) it's otherwise insensitive.
LC_ALL=C
export LC_ALL

sort -k1,1 mrtmp.iiseq | sort -snk2,2 | grep -v '16' | tail -10 | diff - -B -b  mr-challenge.txt > diff.out
if [ -s diff.out ]
then
echo "Failed test. Output should be as in mr-challenge.txt. Your output differs as follows (from diff.out):" > /dev/stderr
  cat diff.out
else
  echo "Passed test" > /dev/stderr
fi

