# Bash Scripts - publish_to

## Purpose

Sick of nasty merge commits messing up your code base in a medium-large collaborative team coding environment? Run this command before any push and be sure before publishing.

Simple little script in bash to publish the current branch that you're on to a target branch (both local or remote). Performing all required git functions to ensure a synced branch with live (pull, rebase, merge etc). At the end of the process a list of all available remote branches is given to push to.

## Install

Either:

 * Clone this repo
		cd ~
		mkdir bashscripts
		cd bashscripts/
		git clone git://github.com/tommeier/bash-publish_to.git publish_to
 * and then add the following line anywhere in your bash_profile (or whatever your bash config is) to include this script
 		source ~/bashscripts/bash-publish_to/bash_publish_to.sh

Or

 * Cut paste the functions in the 'bash_publish_to.sh' file into your ~/.bash_profile (or whatever your bash config file is)

Then

 * Open terminal/bash (or reload if already open, e.g.: 'source ~/.bash_profile')

## Usage

 * Enter the branch you wish to publish *from* and run the following command:
		publish_to <branch you wish to publish to>
 * After viewing the 'git wtf' output that shows status of remote and local branch, and if you're happy with it select the remote you'd like to push to.

For example (on branch 'dev' wanting to publish to 'master' before pushing live):
		branch-dev $ publish_to master

 * For starting at the start of the day (get latest changes and rebase dev branch):
    branch-dev $ startup master

## Requirements

 * git wtf - http://github.com/michaelklishin/git-wtf/ - Clearer display of state on remote and local branches

## To Do
 * Add exception catching for when a conflict occurs.
 * On startup script allow selection of the 'master/dev' branch based on possible branches in git
## Credits

 * Justin French - http://github.com/justinfrench - for the original static publishing requirements
 * Jeremy Friesen - http://reclusive-geek.blogspot.com/ - for the current git branch magic
