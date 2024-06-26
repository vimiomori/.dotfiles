#!/bin/bash

while read line
do
  sshPrefix="git@github.com:"
  ghq get "${line/github.com\//$sshPrefix}"
done < "repos.txt"
