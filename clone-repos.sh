#!/bin/bash

while read line
do
  sshPrefix="git@github.com:"
  gget "${line/github.com\//$sshPrefix}"
done < "repos.txt"
