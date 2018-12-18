# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

#################
# General UI/UX #
#################
[ -e global.defaults ] && source global.defaults

# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

[ -e universalaccess.defaults ] && source universalaccess.defaults
[ -e print.defaults ] && source print.defaults
[ -e launchservices.defaults ] && source launchservices.defaults

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

[ -e systempreferences.defaults ] && source systempreferences.defaults
[ -e helpviewer.defaults ] && source helpviewer.defaults

# Fix for the ancient UTF-8 bug in QuickLook (https://mths.be/bbo)
# Commented out, as this is known to cause problems in various Adobe apps :(
# See https://github.com/mathiasbynens/dotfiles/issues/237
#echo "0x08000100:0" > ~/.CFUserTextEncoding

[ -e loginwindow.defaults ] && source loginwindow.defaults

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# go into computer sleep mode after 20min
sudo systemsetup -setcomputersleep 20

source softwareupdate.defaults


# Disable remote apple events
sudo systemsetup -setremoteappleevents off

# Disable remote login
sudo systemsetup -setremotelogin off

# Disable wake-on modem
sudo systemsetup -setwakeonmodem off

# Disable wake-on LAN
sudo systemsetup -setwakeonnetworkaccess off

# Disable file-sharing via AFP or SMB
# sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist
# sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist

# Automatically lock the login keychain for inactivity after 6 hours
#security set-keychain-settings -t 21600 -l ~/Library/Keychains/login.keychain

# Destroy FileVault key when going into standby mode, forcing a re-auth.
# Source: https://web.archive.org/web/20160114141929/ http://training.apple.com/pdf/WP_FileVault2.pdf
sudo pmset destroyfvkeyonstandby 1

# Disable diagnostic reports
#sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.SubmitDiagInfo.plist

# Log authentication events for 90 days
#sudo perl -p -i -e 's/rotate=seq file_max=5M all_max=20M/rotate=utc file_max=5M ttl=90/g' "/etc/asl/com.apple.authd"

# Log installation events for a year
#sudo perl -p -i -e 's/format=bsd/format=bsd mode=0640 rotate=utc compress file_max=5M ttl=365/g' "/etc/asl/com.apple.install"

# Increase the retention time for system.log and secure.log
#sudo perl -p -i -e 's/\/var\/log\/wtmp.*$/\/var\/log\/wtmp   \t\t\t640\ \ 31\    *\t\@hh24\ \J/g' "/etc/newsyslog.conf"

# Keep a log of kernel events for 30 days
sudo perl -p -i -e 's|flags:lo,aa|flags:lo,aa,ad,fd,fm,-all,^-fa,^-fc,^-cl|g' /private/etc/security/audit_control
sudo perl -p -i -e 's|filesz:2M|filesz:10M|g' /private/etc/security/audit_control
sudo perl -p -i -e 's|expire-after:10M|expire-after: 30d |g' /private/etc/security/audit_control


# "always boot in verbose mode (not MacOS GUI mode)"
#sudo nvram boot-args="-v"

# "allow 'locate' command"
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist > /dev/null 2>&1

# "Set standby delay to 24 hours (default is 1 hour)"
sudo pmset -a standbydelay 86400

# "Disable the sound effects on boot"
#sudo nvram SystemAudioVolume=" "


# "Restart automatically if the computer freezes"
sudo systemsetup -setrestartfreeze on

# "Never go into computer sleep mode"
sudo systemsetup -setcomputersleep Off > /dev/null

# "Disable Notification Center and remove the menu bar icon"
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist > /dev/null 2>&1


########################
# MacBookPro Touch Bar #
########################
# Always display full control strip (ignoring App Controls)
#defaults write com.apple.touchbar.agent PresentationModeGlobal fullControlStrip

#######################
# SSD-specific tweaks #
#######################
# "Disable local Time Machine snapshots"
#sudo tmutil disablelocal

# "Disable hibernation (speeds up entering sleep mode)"
# sudo pmset -a hibernatemode 0

# "Remove the sleep image file to save disk space"
sudo rm -rf /Private/var/vm/sleepimage
# "Create a zero-byte file instead"
sudo touch /Private/var/vm/sleepimage
# "…and make sure it can’t be rewritten"
sudo chflags uchg /Private/var/vm/sleepimage

# "Disable the sudden motion sensor as it’s not useful for SSDs"
sudo pmset -a sms 0

###############################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input #
###############################################################

[ -e driver.defaults ] && source driver.defaults
[ -e mouse.defaults ] && source mouse.defaults
[ -e bluetoothaudioagent.defaults ] && source bluetoothaudioagent.defaults
[ -e sound.defaults ] && source sound.defaults
[ -e systemsound.defaults ] && source systemsound.defaults

# Enable access for assistive devices
echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled

[ -e bezelservices.defaults ] && source bezelservices.defaults

# Stop iTunes from responding to the keyboard media keys
#launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

##########
# Screen #
##########

mkdir $HOME/Pictures/Screenshots
[ -e screencapture.defaults ] && source screencapture.defaults
[ -e windowserver.defaults ] && source windowserver.defaults

##########
# Finder #
##########

[ -e finder.defaults ] && source finder.defaults
[ -e desktopservices.defaults ] && source desktopservices.defaults
[ -e frameworks.defaults ] && source frameworks.defaults
[ -e networkbrowser.defaults ] && source networkbrowser.defaults

# Show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Show item info to the right of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Increase grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

# "Enable the MacBook Air SuperDrive on any Mac"
# sudo nvram boot-args="mbasd=1"

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

####################################
# Dock, Dashboard, and hot corners #
####################################
[ -e dock.defaults ] && source dock.defaults
[ -e dashboard.defaults ] && source dashboard.defaults

# Reset Launchpad, but keep the desktop wallpaper intact
#find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Add iOS & Watch Simulator to Launchpad
#sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"
#sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator (Watch).app" "/Applications/Simulator (Watch).app"

###################
# Safari & WebKit #
###################
[ -e safari.defaults ] && source safari.defaults

########
# Mail #
########
[ -e mail.defaults ] && source mail.defaults

#############
# Spotlight #
#############
# Hide Spotlight tray-icon (and subsequent helper)
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.

[ -e spotlight.defaults ] && source spotlight.defaults

# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

############
# Terminal #
############
[ -e terminal.defaults ] && source terminal.defaults

################
# Time Machine #
################
[ -e timemachine.defaults ] && source timemachine.defaults

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

####################
# Activity Monitor #
####################
[ -e activitymonitor.defaults ] && source activitymonitor.defaults

#############################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility #
#############################################################
[ -e addressbook.defaults ] && source addressbook.defaults
[ -e dashboard.defaults ] && source dashboard.defaults
[ -e ical.defaults ] && source ical.defaults
[ -e textedit.defaults ] && source textedit.defaults
[ -e diskutility.defaults ] && source diskutility.defaults
[ -e quicktimeplayerx.defaults ] && source quicktimeplayerx.defaults

#################
# Mac App Store #
#################
[ -e appstore.defaults ] && source appstore.defaults

##########
# Photos #
##########
[ -e imagecapture.defaults ] && source imagecapture.defaults

############
# Messages #
############
[ -e messageshelper.defaults ] && source messageshelper.defaults

##########
# Google #
##########
[ -e google.defaults ] && source google.defaults


#########
# Opera #
#########
[ -e operasoftware.defaults ] && source operasoftware.defaults

###########
# Twitter #
###########
[ -e twitter.defaults ] && source twitter.defaults

#####################################
# Divisible By Zero (Spectacle.app) #
#####################################
[ -e divisiblebyzero.defaults ] && source divisiblebyzero.defaults
