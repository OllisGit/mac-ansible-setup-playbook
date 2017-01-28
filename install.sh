#!/bin/sh

# Be prepared to turn your OSX box into
# a development beast.
#
# This script bootstraps a OSX laptop to a point where we can run
# Ansible on localhost. It;
#  1. Installs
#    - xcode
#    - homebrew
#    - ansible (via brew)
#    - a few ansible galaxy playbooks (zsh, homebrew, cask etc)
#  2. Kicks off the ansible playbook
#    - main.yml
#
# It will ask you for your sudo password

# Prompt the user for their sudo password
sudo -v

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

fancy_echo "Boostrapping ..."

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

# Ensure Apple's command line tools are installed
if ! command -v cc >/dev/null; then
  fancy_echo "Installing xcode ..."
  xcode-select --install
else
  fancy_echo "Xcode already installed. Skipping."
fi

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
else
  fancy_echo "Homebrew already installed. Skipping."
fi

# [Install Ansible](http://docs.ansible.com/intro_installation.html).
if ! command -v ansible >/dev/null; then
  fancy_echo "Installing Ansible ..."
  brew install ansible
else
  fancy_echo "Ansible already installed. Skipping."
fi

WHOAMI=$(whoami);

# Clone the repository to your local drive.
if [[ -d "/Users/${WHOAMI}/.setup" ]]; then
    echo "Removing playbook";
    rm -rf "/Users/${WHOAMI}/.setup";
fi
fancy_echo "Cloning .setup repo ..."
git clone https://github.com/MNicks/mac-dev-playbook.git "/Users/${WHOAMI}/.setup";

echo "Changing permissions for /usr/local"
sudo chown root:admin /usr/local && chmod 0775 /usr/local

fancy_echo "Changing to .setup repo dir ..."
cd "/Users/${WHOAMI}/.setup/";

echo "Installing requirements";
ansible-galaxy install -r ./requirements.yml;

# Run this from the same directory as this README file.
fancy_echo "Running ansible playbook ..."
ansible-playbook ./main.yml -i hosts --ask-sudo-pass -vvvv

echo "Done.";
