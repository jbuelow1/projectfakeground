#!/bin/bash

json=$(curl https://jbuelow1.github.io/projectfakeground/Server/fakeground.json)
masterswitch=$(echo $json | grep -Po '"masterswitch":.*?[^\\]",')

echo "Starting..."
if [[ $masterswitch == *"true"* ]]
then
  echo "masterswitch is enabled!"
  me_enabled=$(echo $json | grep -Po '"andrew_enabled":.*?[^\\]",')
  if [[ $me_enabled == *"true"* ]]
  then
    echo "This device is enabled!"
    image_id=$(echo $json | grep -Po '"andrew_id":.*?[^\\]",' | cut -d '"' -f 4)
    current_id=$(cat .current_id)
    if [ "$image_id" != "$current_id" ]
    then
      echo "New image discovered!"
      image_format=$(echo $json | grep -Po '"andrew_format":.*?[^\\]",' | cut -d '"' -f 4)
      image_url=$(echo $json | grep -Po '"andrew_url":.*?[^\\]",' | cut -d '"' -f 4)
      curl -o ${HOME}/.background.$image_format $image_url
      sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '${HOME}/.background.$image_format'"
      killall Dock
      echo "Done."
    fi
  fi
fi
exit
