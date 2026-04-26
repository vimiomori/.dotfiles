#!/usr/bin/env zsh

# jq output to array method from
# https://stackoverflow.com/questions/54087481/assigning-an-array-parsed-with-jq-to-bash-script-array
WINDOWS=($((yabai -m query --windows | jq -r 'map(select(.app == "Arc")) | .[] .id | @sh') | tr -d \'))
if [ "${#WINDOWS[@]}" -eq "1" ]; then
  yabai -m window $YABAI_WINDOW_ID move --space web
elif [ "${#WINDOWS[@]}" -eq "2" ]; then
  yabai -m window $YABAI_WINDOW_ID move --space maincode
else
  echo $YABAI_WINDOW_ID
fi

