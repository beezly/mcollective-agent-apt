mcollective-agent-apt
=====================

Make apt commands accessible through mcollective (https://puppetlabs.com/mcollective/).

Commands
--------

### get_upgrades

Returns an object of packages available to be installed as returned by `apt-get dist-upgrade`

### update

Executes an `apt-get update` and returns the output

### upgrade

Executes an `apt-get upgrade` and returns the output

### distupgrade

Executes an `apt-get dist-upgrade` and returns the output

### install 

Takes an input of a package name and installs the package with `apt-get install <package>`
	
### remove

Takes an input of a package name and removes the package with `apt-get remove <package>`
	
