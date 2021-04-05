#!/QOpenSys/usr/bin/sh
# To fix up directory permissions after running ssh-copy-id to copy your keys to IBM i
# Download and run this script, or copy/paste the following commands into an IBM i shell (preferrably SSH)
chown -R `/QOpenSys/usr/bib/id -u -n` $HOME/.ssh
chmod 0755 $HOME
chmod 0700 $HOME/.ssh
chmod 0644 $HOME/.ssh/authorized_keys
