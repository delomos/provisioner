#!/bin/bash

SSH_FIX_FILE="/etc/sudoers.d/root_ssh_agent"
if [ ! -f  $SSH_FIX_FILE ]
    then
    echo "Defaults env_keep += \"SSH_AUTH_SOCK\"" > $SSH_FIX_FILE
    chmod 0440 $SSH_FIX_FILE
fi

echo 'installing bundler'
sudo gem install bundle --no-rdoc 
echo 'done'

cd /vagrant

#echo 'Installing Node packages...'
#npm install >/dev/null
#echo 'Done!'

#echo 'Setting up Bower...'
#bower install --allow-root >/dev/null
#echo 'Done!'


echo 'Installing gems...'
bundle install 
echo 'Done!'

echo 'Updating composer packages...'
composer update
echo 'Done!'

