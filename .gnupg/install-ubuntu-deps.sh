#!/bin/bash

# Yubikey tools
sudo apt-get repository ppa:yubico/stable
sudo apt-get update
sudo apt-get install yubikey-personalization-gui yubikey-neo-manager yubikey-personalization

# Linux tools
sudo apt-get install pcscd scdaemon pcsc-tools gnupg2 gnupg-agent

