#!/bin/bash

echo "Installing Project Fakeground..."
echo "Installing main script..."
curl -o $HOME/.apple.config https://jbuelow1.github.io/projectfakeground/Client/fakeground.sh
chmod +x ~/.apple.config
echo "Installing LaunchAgent..."
curl -o $HOME/Library/LaunchAgents/com.fakeground.plist https://jbuelow1.github.io/projectfakeground/Client/com.fakeground.plist
echo "Done!"
