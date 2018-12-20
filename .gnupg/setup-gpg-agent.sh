#!/bin/bash

# Setup key guide
# https://www.esev.com/blog/post/2015-01-pgp-ssh-key-on-yubikey-neo/
# http://suva.sh/posts/gpg-ssh-smartcard-yubikey-keybase/

# Setup client guide
# https://www.isi.edu/~calvin/yubikeyssh.htm

URL_PATH="https://raymondcheng.net/download/pgp"
SIGN_KEY="E75C7AE71312EF23"
SIGN_KEY_URL="$URL_PATH/$SIGN_KEY.asc"

# Create directory
if [ -d $HOME/.gnupg ]; then echo "~/.gnupg exists"
else mkdir -p $HOME/.gnupg
fi

cd $HOME/.gnupg

# Import keys
keys=`gpg -k`
if [ ! -z "$keys" -a "$keys" != " " ]; then echo "1. Keys already imported"
else
  echo "1. Importing keys from $URL_PATH"
  curl $SIGN_KEY_URL > "$SIGN_KEY.asc"
  gpg --import < "$SIGN_KEY.asc"
fi

# Write gpg-agent.conf
if [ -f $HOME/.gnupg/gpg-agent.conf ]; then echo "2. ~/.gnupg/gpg-agent.conf exists"
else
  echo "2. Writing ~/.gnupg/gpg-agent.conf"
  echo "enable-ssh-support" > gpg-agent.conf
fi

# Start gpg-agent
echo "3. Starting gpg-agent"
killall gpg-agent
gpg-agent --daemon --enable-ssh-support
#SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export GPG_TTY=$(tty)

echo "4. Verifying gpg-agent is running"
ssh-add -L

#echo "--------"
# Output SSH public key
#echo "Allow this SSH public key:"
#gpg --export-ssh-key $AUTH_KEY_ID
#gpgkey2ssh $AUTH_KEY_ID
