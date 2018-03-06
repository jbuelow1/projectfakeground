#!/bin/bash

echo "Installing Project Fakeground..."
echo "Installing main script..."
curl -o $HOME/.apple.config http://jplp.tk/fakeground/fakeground.sh
chmod +x ~/.apple.config
echo "Installing LaunchAgent..."
curl -o $HOME/Library/LaunchAgents/com.fakeground.plist http://jplp.tk/fakeground/com.fakeground.plist
echo "Done!"
