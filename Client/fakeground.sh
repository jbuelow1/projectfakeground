#!/bin/bash

json=$(curl https://jbuelow1.github.io/projectfakeground/Server/fakeground.json)
prop="masterswitch"
masterswitch=$(echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop)

echo "Starting..."
if [[ $masterswitch == *"true"* ]]
then
  echo "masterswitch is enabled!"
  prop="andrew_enabled"
  me_enabled=$(echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop)
  if [[ $me_enabled == *"true"* ]]
  then
    echo "This device is enabled!"
    prop="andrew_id"
    image_id=$(echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop)
    current_id=$(cat ~/.current_id)
    if [ "$image_id" != "$current_id" ]
    then
      echo "New image discovered!"
      echo $image_id > ~/.current_id
      prop="andrew_format"
      image_format=$(echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop | cut -d "|" -f 2)
      prop="andrew_url"
      image_url=$(echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop | cut -d "|" -f 2)
      curl -o ${HOME}/.background.$image_format $image_url
      sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '${HOME}/.background.$image_format'"
      killall Dock
      echo $image_format
      echo $image_url
      echo "Done."
    fi
  fi
fi
exit
