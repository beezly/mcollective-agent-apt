mcollective-agent-apt
=====================

Make apt commands accessible through mcollective (https://puppetlabs.com/mcollective/).

Commands
--------

At the moment only one;

    get_upgrades

Which returns an object of packages available to be installed as returned by `apt-get dist-upgrade`