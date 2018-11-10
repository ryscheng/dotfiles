#!/bin/bash

# Setup key guide
# https://www.esev.com/blog/post/2015-01-pgp-ssh-key-on-yubikey-neo/
# http://suva.sh/posts/gpg-ssh-smartcard-yubikey-keybase/

# Setup client guide
# https://www.isi.edu/~calvin/yubikeyssh.htm

KEY_FILE="A54149F9DE1419A939455E6ECAF11E602D6FD561-75F74E2556BC1232.asc"
KEY_URL="https://raymondcheng.net/download/pgp/A54149F9DE1419A939455E6ECAF11E602D6FD561-75F74E2556BC1232.asc"
AUTH_KEY_ID="75F74E2556BC1232"

# Create directory
if [ -d $HOME/.gnupg ]; then echo "~/.gnupg exists"
else mkdir -p $HOME/.gnupg
fi

cd $HOME/.gnupg

# Import keys
keys=`gpg -k`
if [ ! -z "$keys" -a "$keys" != " " ]; then echo "1. Keys already imported"
else
  echo "1. Importing keys from $KEY_URL"
  curl $KEY_URL > $KEY_FILE
  gpg --import < $KEY_FILE
fi

# Write gpg-agent.conf
if [ -f $HOME/.gnupg/gpg-agent.conf ]; then echo "2. ~/.gnupg/gpg-agent.conf exists"
else
  echo "2. Writing ~/.gnupg/gpg-agent.conf"
  echo "enable-ssh-support" > gpg-agent.conf
#  echo "write-env-file" >> gpg-agent.conf
#  echo "use-standard-socket" >> gpg-agent.conf
fi

# Start gpg-agent
echo "3. Starting gpg-agent"
killall gpg-agent
gpg-agent --daemon --enable-ssh-support
#export GPG_AGENT_INFO
SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK
export GPG_TTY=$(tty)

echo "4. Verifying gpg-agent is running"
ssh-add -L

echo "--------"

# Output SSH public key
echo "Allow this SSH public key:"
gpg --export-ssh-key $AUTH_KEY_ID
#gpgkey2ssh $AUTH_KEY_ID
