#!/bin/sh

HOST=$(networksetup -getmacaddress en0 | awk '{print $3}')
read -p "Please provide desired hostname (${HOST})"
if [ -n $REPLY ]; then
  HOST=$REPLY
fi

sudo install -m 0775 -g admin -d /opt

# Set computer name
sudo sciutil --set ComputerName $HOST
sudo sciutil --set HostName $HOST
sudo sciutil --set LocalHostName $HOST
exec $SHELL -l

# Enable location services
sudo defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -bool true
chown -R _locationd:_locationd /var/db/locationd

# Enable automatic timezone update
defaults write /Library/Preferences/com.apple.timezone.auto Active -bool true
defaults write /Library/Preferences/com.apple.locationmenu ShowSystemServices -bool true

# Enable network time (sudo requiried, authorization)
sudo systemsetup -setusingnetworktime on
sudo systemsetup -setnetworktimeserver 0.us.pool.ntp.org
sudo tee /etc/ntp.conf << EOF
1.us.pool.ntp.org
2.us.pool.ntp.org
3.us.pool.ntp.org
EOF

# Set misc. settings
# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on
# Never go into computer sleep mode
#sudo systemsetup -setcomputersleep Off > /dev/null

# Update system
sudo softwareupdate -i -a
