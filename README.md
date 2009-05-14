# Bash Scripts - publish_to

## Purpose

Sick of nasty merge commits messing up your code base in a medium-large collaborative team coding environment? Run this command before any push and be sure before publishing.

Simple little script in bash to publish the current branch that you're on to a target branch (both local or remote). Performing all required git functions to ensure a synced branch with live (pull, rebase, merge etc).
  
## Install

 * Cut paste the functions in the 'bash_profile' file into your ~/.bash_profile (or whatever your bash config file is)
 * Open terminal/bash (or reload if already open, e.g.: 'source ~/.bash_profile')

## Usage

 * Enter the branch you wish to publish *from* and run the following command:
		publish_to <branch you wish to publish to>
 * After viewing the 'git wtf' output that shows status of remote and local branch, and if you're happy with it respond 'y' to push branch.

For example (on branch 'dev' wanting to publish to 'master' before pushing live):
		branch-dev $ publish_to master
		
## Requirements

 * git wtf - http://github.com/michaelklishin/git-wtf/ - Clearer display of state on remote and local branches

## Credit

 * Justin French - http://github.com/justinfrench - for the original static publishing requirements
 * Jeremy Friesen - http://reclusive-geek.blogspot.com/ - for the current git branch magic

## ToDo 
 * Display git diff pretty graph if push is not selected to display one line differences.
 * Switch request statement to be fixed options.
 * Make comments clearer in listings
 *Fix up README to explain purpose and what it does