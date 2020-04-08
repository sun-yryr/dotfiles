#!/bin/sh

DIR_PATH=$(cd $(dirname $0); pwd)

cat ./extensions | while read line
do
  code --install-extension $line
done

ln -sf "$DIR_PATH/settings.json" "$HOME/Library/Application Support/Code/User/"
