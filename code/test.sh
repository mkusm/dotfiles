#! /bin/bash

sudo apt -y install curl
curl -sL https://downloads.slack-edge.com/linux_releases/slack-desktop-4.8.0-amd64.deb -o slack.deb && sudo apt -y install ./slack.deb
