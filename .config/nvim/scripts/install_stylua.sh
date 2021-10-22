#!/bin/bash

DOWNLOAD_URL=$(curl -s https://api.github.com/repos/JohnnyMorganz/StyLua/releases/latest \
	| grep browser_download_url \
	| grep linux \
	| cut -d '"' -f 4)

curl -L $DOWNLOAD_URL > stylua.zip
unzip stylua.zip
mv stylua $HOME/.local/bin/stylua
chmod +x $HOME/.local/bin/stylua
rm stylua.zip
