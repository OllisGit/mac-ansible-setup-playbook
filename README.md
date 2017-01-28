# Mac Development Ansible Playbook

This playbook installs and configures most of the software I use on my Mac for web and software development.

This playbook will be updated throughout my life with various features, functions and roles - but they will always convey the same purpose.

## Installation

  Run the following from the command line, and enter your administrative password when requested.
  
  Note that initially you'll need to install xcode command line tools before you can proceed.
  
### App store Authentication
  
  Note that MACSTOREUSER and MACSTOREPASS will need to be replaced with your details, and MAS must be a part of homebrew's package list.
  
  1. `xcode-select --install`
  2. `curl https://raw.githubusercontent.com/MNicks/mac-dev-playbook/master/install.sh | bash -s -- MACSTOREUSER MACSTOREPASS`


### Non-authenticated method.
  
  If your user account is definitely logged into the Apple store, authentication isn't essential so you can use the following instead of the above commands.
  
  1. `xcode-select --install`
  2. `curl https://raw.githubusercontent.com/MNicks/mac-dev-playbook/master/install.sh | bash`

## Included Applications / Configuration

###Applications (installed with Homebrew Cask):

  - ccleaner
  - dropbox
  - firefoxdeveloperedition
  - gitkraken
  - google-chrome
  - google-drive
  - iterm2
  - vlc

### Packages (installed with Homebrew):

  - ansible
  - dockutil
  - git
  - go
  - gpg
  - python
  - mcrypt
  - npm
  - nvm
  - ssh-copy-id
  - cowsay
  - readline
  - subversion
  - openssl
  - drush
  - wget
  
### Apple Store Products

  - BlackMagic Disk Speed test
  - Microsoft OneDrive

My [dotfiles](https://github.com/fubarhouse/mac-dev-playbook-dotfiles) are also installed into the current user's home directory.

## Ansible for DevOps

Check out [Ansible for DevOps](http://www.ansiblefordevops.com/), which will teach you how to do some other amazing things with Ansible.

## Special thanks

[Jeff Geerling](http://jeffgeerling.com/) for creating the amazing [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook).

## Authors/Contributors

[Karl Hepworth](http://twitter.com/fubarhouse), Making this fork more personalized.

[Jeff Geerling](http://jeffgeerling.com/), 2014 (originally inspired by [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks)).
