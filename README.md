# Mac Development Ansible Playbook

This playbook installs and configures most of the software I use on my Mac for web and software development.

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

It also installs a few useful system preferences/settings/tweaks with a toned-down verson of Matt Mueller's [OSX-for Hackers script](https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716).

It does some reasonably gnarly stuff e.g.

  - hide spotlight icon
  - disable app Gate Keeper
  - change stand-by delay from 1hr to 12hrs.
  - Set trackpad tracking rate.
  - Set mouse tracking rate.
  - and lots more...

so you need read it very carefully first. (see scripts/system_settings.sh)

TODO: moar sick settings with https://github.com/ryanmaclean/OSX-Post-Install-Script

### User Preferences

It then syncs your user prefs with dotfiles+rcm

It grabs the [thoughttbot/dotfiles](https://github.com/thoughtbot/dotfiles) repo, saves it in `~/src_dotfiles/thoughtbot/dotfiles` and symlinks it to ~/dotfiles.

It then grabs [MNicks/dotfiles](https://github.com/MNicks/dotfiles) repo, saves it in `~/src_dotfiles/MNicks/dotfiles` and symlinks it to ~/dotfiles-local

You probably want to change the `dotfile_repo_username` variable in `vars/main.yml`to match your github username :-)

It then runs rcup to initialize your dotfiles.

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
