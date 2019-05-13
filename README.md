# Mac Development Ansible Playbook

This playbook installs and configures most of the software I use on my Mac for web and software development.

## Short overview how it works

1. Download ````install.sh```` from github-master (see below sh/curl-command)
2. The script does the following:
    - check/install for "Apple Command Line tools"
    - check/install "Homebrew"
    - check/install(via brew) "Ansible"
    - clone ````this git```` to local folder nammed ````/Users/<yourName>/.setup````
3. Execute the ansible-playbook: ````./main.yml````. It includes the following tasks/roles:
    - DockUtil      Remove/Add/Move Items releated to Dock-Bar

Depending on your setup requirments you need to change the following files:

| Filename | Content |
|----------|---------|
| vars/main.yml                | Update dotfile_repo_username                                   |
| vars/dockutil.yml            | Lists all DockItems you want                                   |
| vars/homebrew.yml            | Lists all Application you want to install via brew/cask        |
| tasks/main.yml                | oy-my-zsh, dotfiles, Monolingual (removes languages)          |
| scripts/system_settings.sh    | System Settings like hide Spotlight-Icon, etc                 |

## Installation

### Fast Install

If you'd like to start with my default list of tools and apps (see Included Apps/Config below), then simply install with;

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/MNicks/mac-dev-playbook/master/install.sh)"

You can always customize the install after-the-fact (see below), and re-run the playbook. It will skip over any installed apps.

### Custom Install

If you want to add/remove to the list of apps/utils installed, its pretty straightforward.

As above, download and bootstrap the script. But stop it before it starts ansible, and edit the playbook as desired, before re-running ansible.

1. Grab and start the bootstrap script. Let it install the prereqs and clone the full `~/.setup` repo locally...

      sh -c "$(curl -fsSL https://raw.githubusercontent.com/MNicks/mac-dev-playbook/master/install.sh)"


1. Stop the script (Ctrl+C) when ansible asks for the a 'sudo' password.

        ```
        Changing to laptop repo dir ...

        Running ansible playbook ...
        SUDO password:  ^c

        ```

1. Change into the cloned repo dir

        `cd ~/.setup`

1. Edit ./vars/vars-homebrew.yml and add/remove the apps/utils you want.

        `vi ./vars/vars-homebrew.yml`

1. Kick off ansible manually

        `ansible-playbook main.yml -i hosts --ask-sudo-pass -vvvv`

You can do this as many times as you like and re-run the `ansible-playbook` command. Ansible is smart enough to skip installed apps, so subsequent runs are super fast.

### System Settings

It also installs a few useful system preferences/settings/tweaks with a toned-down version of Matt Mueller's [OSX-for Hackers script](https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716).

It does some reasonably gnarly stuff e.g.

  - hide spotlight icon
  - disable app Gate Keeper
  - change stand-by delay from 1hr to 12hrs.
  - Set trackpad tracking rate.
  - Set mouse tracking rate.
  - and lots more...

so you need read it very carefully first. (see scripts/system_settings.sh)

TODO: more sick settings with https://github.com/ryanmaclean/OSX-Post-Install-Script

### User Preferences

In addition it user specific preferences (dotfiles) will pulled from Github as well

1. Grabbing [thoughttbot/dotfiles](https://github.com/thoughtbot/dotfiles) repo, saves it in `~/src_dotfiles/thoughtbot/dotfiles` and symlinks it to ~/dotfiles.

1. Grabbing [MNicks/dotfiles](https://github.com/MNicks/dotfiles) repo, saves it in `~/src_dotfiles/MNicks/dotfiles` and symlinks it to ~/dotfiles-local

1. Running `rcup` to initialize your dotfiles.

You probably want to change the `dotfile_repo_username` variable in `vars/main.yml`to match your github username and therefore you personal dotfiles :-)


## Included Applications / Configuration

### Applications

Apps installed with Homebrew Cask:

  - apptrap # remove associated prefs when uninstalling
  - appzapper # uninstaller
  #- atom # sublime without annoying popup | https://atom.io/download/mac
  - bettertouchtool # window snapping. (maybe Moom is more lightweight?)
  - captur #ui wrapper for osx screenscraper
  - cheatsheet # know your shortcuts
  - cyberduck # ftp, s3, openstack
  - dash # totally sick API browser
  - diffmerge # free visual diq
  - disk-inventory-x # reclaim space on your expensive-ass Apple SSD | http://www.derlien.com/
  - dropbox # a worse Mega Sync
  - eve # learn your shortcuts
  - firefox
  - firefoxdeveloperedition
  - font-hack-nerd-font
  - go2shell
  - imageoptim # optimize images
  - istumbler # network discovery GUI
  - intellij-idea
  - iterm2
  - jumpcut # awesome clipboard
  - karabiner # Keyboard customization
  - keka # file archiving
  - licecap # GIFs !
  - mactracker # benchmarking
  - monolingual # remove unneeded osx lang files
  - nvalt # fast note taking
  - onedrive
  - onyx # system maintenance
  - qlcolorcode # quick look syntax highlighting
  - qlimagesize # quick look image dimensions
  - qlmarkdown # quick look .md files
  - qlstephen # quick look extension-less text files
  - sequel-pro # FREE SQL GUI!
  - shortcat # kill your mouse
  - shuttle # ssh management
  - sourcetree
  #- sts
  - transmission # torrents
  - tunnelblick
  - visual-studio-code
  - wifi-explorer
  - java # Installs Java8

There are several more common cask apps listed in the ./vars/vars-homebrew.yml - simply uncomment them to include them in your install. 


### Packages/Utilities 
 
Things installed with Homebrew:

  - ack
  - autoconf
  - autojump # quickly navigate from cmd line
  - bash # Bash 4
  - bash-completion
  - battery
  - bazel
  - bfg
  - brew-cask-completion
  - cowsay # amazing
  - coreutils # Install GNU core utilities (those that come with OS X are outdated)
  - docker # | https://docs.docker.com/installation/mac/
  - docker-clean
  - docker-cloud
  - docker-compose
  - docker-gen
  - docker-machine
  - docker-swarm
  - findutils  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
  - httpie
  - git
  - jq
  - hub # github
  - launchctl-completion
  - libevent
  - libffi
  - libvterm
  - libxml2
  - libyaml
  - macvim
  - mas
  - maven
  - mcrypt
  - md5sha1sum
  - mobile-shell
  - moreutils
  - mtr # better traceroute
  - node
  - npm
  - nvm
  - openssl
  - packer
  - packer-completion
  - pandoc
  - parallel
  - pip-completion
  - postgresql
  - pup
  - pv
  - ssh-copy-id
  - readline
  - rename # rename multiple files
  - rsync
  - the_silver_searcher # fast ack-grep
  - tmux
  - tree
  - tmux
  - vim
  - wget
  - zsh

There are several more utils listed in the /vars/vars-homebrew.yml - simply uncomment them to include them in your install. 

## Ansible for DevOps

Check out [Ansible for DevOps](http://www.ansiblefordevops.com/), which will teach you how to do some other amazing things with Ansible.

## Special thanks

[Jeff Geerling](http://jeffgeerling.com/) for creating the amazing [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook).

Nauman Leghari for his [mac-dev-playbook](https://github.com/nauman-leghari-wipro/mac-dev-playbook) adaption which was used as basis for this repo
