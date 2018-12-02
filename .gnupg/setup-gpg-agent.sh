#!/bin/bash

# Setup key guide
# https://www.esev.com/blog/post/2015-01-pgp-ssh-key-on-yubikey-neo/
# http://suva.sh/posts/gpg-ssh-smartcard-yubikey-keybase/

# Setup client guide
# https://www.isi.edu/~calvin/yubikeyssh.htm

KEY_FILE="A54149F9DE1419A939455E6ECAF11E602D6FD561-75F74E2556BC1232.asc"
KEY_URL="https://raymondcheng.net/download/pgp/A54149F9DE1419A939455E6ECAF11E602D6FD561-75F74E2556BC1232.asc"
AUTH_KEY_ID="75F74E2556BC1232"

URL_PATH="https://raymondcheng.net/download/pgp"
MASTER_KEY="A54149F9DE1419A939455E6ECAF11E602D6FD561"
AUTHENTICATE_KEY="75F74E2556BC1232"
ENCRYPT_KEY="8B00F38A32202B98"
SIGN_KEY="9E54F484C328ACE5"
AUTHENTICATE_KEY_URL="$URL_PATH/$MASTER_KEY-$AUTHENTICATE_KEY-authenticate.asc"
ENCRYPT_KEY_URL="$URL_PATH/$MASTER_KEY-$ENCRYPT_KEY-encrypt.asc"
SIGN_KEY_URL="$URL_PATH/$MASTER_KEY-$SIGN_KEY-sign.asc"


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
  curl $AUTHENTICATE_KEY_URL > "$AUTHENTICATE_KEY.asc"
  curl $ENCRYPT_KEY_URL > "$ENCRYPT_KEY.asc"
  curl $SIGN_KEY_URL > "$SIGN_KEY.asc"
  gpg --import < "$AUTHENTICATE_KEY.asc"
  gpg --import < "$ENCRYPT_KEY.asc"
  gpg --import < "$SIGN_KEY.asc"
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
#SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export GPG_TTY=$(tty)

echo "4. Verifying gpg-agent is running"
ssh-add -L

echo "--------"

# Output SSH public key
echo "Allow this SSH public key:"
gpg --export-ssh-key $AUTH_KEY_ID
#gpgkey2ssh $AUTH_KEY_ID
