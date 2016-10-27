#!/bin/bash

# Usage:
# install.sh accout@apple.com password

# Prompt the user for their sudo password
sudo -v

# Enable passwordless sudo for the macbuild run
sudo sed -i -e "s/^%admin.*/%admin  ALL=(ALL) NOPASSWD: ALL/" /etc/sudoers

if [[ -z $(which brew) ]]; then
  echo "Installing Homebrew...";
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null;
fi

if [[ -z $(which ansible) ]]; then
    echo "Installing Ansible";
    brew install ansible;
fi

WHOAMI=$(whoami);

if [[ -d "/Users/${WHOAMI}/Documents/dotfiles" ]]; then
    echo "Removing dotfiles";
    rm -rf "/Users/${WHOAMI}/Documents/dotfiles";
fi
if [[ -d "/Users/${WHOAMI}/.setup" ]]; then
    echo "Removing playbook";
    rm -rf "/Users/${WHOAMI}/.setup";
fi

git clone https://github.com/nauman-leghari-wipro/mac-dev-playbook.git "/Users/${WHOAMI}/.setup";
git clone https://github.com/nauman-leghari-wipro/mac-dev-playbook-dotfiles.git "/Users/${WHOAMI}/Documents/dotfiles";

if [[ -n $1 ]] && [[ -n $2 ]]; then
    EXTRAVARS="app_store_email=$1 app_store_password=$2";
else
    EXTRAVARS="a=b";
fi

cd "/Users/${WHOAMI}/.setup/";

echo "Installing requirements";
ansible-galaxy install -r ./requirements.yml;

echo "Initiating playbook";

ansible-playbook ./main.yml -i inventory -U $(whoami) --ask-sudo-pass --extra-vars "${EXTRAVARS}";

# Disable passwordless sudo after the macbuild is complete
sudo sed -i -e "s/^%admin.*/%admin  ALL=(ALL) ALL/" /etc/sudoers

echo "Done.";
