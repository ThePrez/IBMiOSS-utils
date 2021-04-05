#!/QOpenSys/usr/bin/sh
chown -R `/QOpenSys/usr/bib/id -u -n` $HOME/.ssh
chmod 0755 $HOME
chmod 0700 $HOME/.ssh
chmod 0644 $HOME/.ssh/authorized_keys
