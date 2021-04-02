#!/QOpenSys/usr/bin/sh
chown -R `whoami` $HOME/.ssh
chmod 0755 $HOME
chmod 0700 $HOME/.ssh
chmod 0644 $HOME/.ssh/authorized_keys
