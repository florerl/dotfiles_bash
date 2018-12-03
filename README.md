# dotfiles
H/T: https://github.com/holman/dotfiles

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## what's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork it](https://github.com/holman/dotfiles/fork), remove what you don't
use, and build on what you do use.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **Brewfile**: This is a list of applications for [Homebrew Cask](https://caskroom.github.io) to install: things like Chrome and 1Password and Adium and stuff. Might want to edit this file before running any initial setup.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## install

Run this:

```sh
git clone https://github.com/holman/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.



## Bootstrap ToDo:

1. Set name (sudo required, authorization)

    - ```sudo sciutil --set ComputerName $HOST`
       sudo sciutil --set HostName $HOST`
       sudo sciutil --set LocalHostName $HOST```
    
    - `exec bash -l`
    
1. Enable location services (sudo required, hidden from User)

    - `sudo defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1`
    
    - `chown -R _locationd:_locationd /var/db/locationd`
    
1. Enable automatic timezone update

    - `defaults write /Library/Preferences/com.apple.timezone.auto Active -bool true`
    
    - `defaults write /Library/Preferences/com.apple.locationmenu ShowSystemServices -bool true`
    
1. Enable network time (sudo requiried, authorization)

    ```
    sudo systemsetup -setusingnetworktime on
    sudo systemsetup -setnetworktimeserver 0.us.pool.ntp.org
    sudo tee /etc/ntp.conf << EOF
    1.us.pool.ntp.org
    2.us.pool.ntp.org
    3.us.pool.ntp.org
    EOF
    ```

1. Set misc. system settings

    ```
      # Set standby delay to 3 hours (default is 1 hour)
    sudo pmset -a standbydelay 10800  
      # Set sidebar icon size to small
    defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1 
      # Set scrollbar behavior: `WhenScrolling`, `Automatic`, `Always`
    defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"
      # Expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
      # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
      # Automatically quit printer app once the print jobs complete
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
      # Display ASCII control characters using caret notation in standard text views
      # Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
    defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true
      # Enable Resume system-wide
    defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool true
      # Disable automatic termination of inactive apps
    defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

      # Enable the crash reporter...
    #defaults write com.apple.CrashReporter DialogType -string "none"

      # Set Help Viewer windows to non-floating mode
    defaults write com.apple.helpviewer DevMode -bool true
      # Reveal IP address, hostname, etc. when clicking the clock in the login window
    sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
      # Restart automatically if the computer freezes
    sudo systemsetup -setrestartfreeze on
   
      # Never go into computer sleep mode
    #sudo systemsetup -setcomputersleep Off > /dev/null

      # Disable smart quotes as they’re annoying when typing code
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
      # Disable smart dashes as they’re annoying when typing code
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
      # Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
      # all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
    #rm -rf ~/Library/Application Support/Dock/desktoppicture.db
    #sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
    #sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

    # Trackpad, mouse, keyboard, Bluetooth accessories, and input
      # Trackpad: enable tap to click for this user and for the login screen
    #defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    #defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
    #defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 0

      # Trackpad: map bottom right corner to right-click
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
    # defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
    # defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

      # Enable “natural” (Lion-style) scrolling
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

      # Increase sound quality for Bluetooth headphones/headsets
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

      # Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

      # Use scroll gesture with the Ctrl (^) modifier key to zoom
    #defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
    #defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
      
      # Follow the keyboard focus while zoomed in
    # defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

      # Disable press-and-hold for keys in favor of key repeat
    # defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    defaults write com.apple.Terminal ApplePressAndHoldEnabled -bool false
    # defaults write Oni ApplePressAndHoldEnabled -bool false

      # Set a blazingly fast keyboard repeat rate
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 10

      # Set language and text formats
    defaults write NSGlobalDomain AppleLanguages -array "en" "us"
    defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
    defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
    defaults write NSGlobalDomain AppleMetricUnits -bool false


      # Disable auto-correct
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    # Screen
      # Require password 'soon' after sleep or screen saver begins
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 15

      # Save screenshots to the desktop
    # defaults write com.apple.screencapture location -string "${HOME}/Desktop"

      # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png"

      # Disable shadow in screenshots
    # defaults write com.apple.screencapture disable-shadow -bool true

      # Enable subpixel font rendering on non-Apple LCDs
    defaults write NSGlobalDomain AppleFontSmoothing -int 2

      # Enable HiDPI display modes (requires restart)
    sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

    # Finder
      # Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
    defaults write com.apple.finder QuitMenuItem -bool true

      # Set ${HOME} directory (~) as the default location for new Finder windows
      # More options here: https://github.com/mathiasbynens/dotfiles/blob/96edd4b57047f34ffbcbb708e1e4de3a2e469925/.macos#L233
    defaults write com.apple.finder NewWindowTarget -string "PfLo"
    #defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

    # Show icons for hard drives, servers, and removable media on the desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
    
    # Finder: show hidden files by default
    # defaults write com.apple.finder AppleShowAllFiles -bool true
    
    # Finder: show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    
    # Finder: show status bar
    defaults write com.apple.finder ShowStatusBar -bool true
    
    # Finder: show path bar
    defaults write com.apple.finder ShowPathbar -bool true
    
    # Display full POSIX path as Finder window title
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
    
    # Keep folders on top when sorting by name
    defaults write com.apple.finder _FXSortFoldersFirst -bool true
    
    # When performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    
    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    
    # Enable spring loading for directories
    defaults write NSGlobalDomain com.apple.springing.enabled -bool true
    
    # Remove the spring loading delay for directories
    defaults write NSGlobalDomain com.apple.springing.delay -float 0
    
    # Avoid creating .DS_Store files on network or USB volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
    
    # Disable disk image verification
    # defaults write com.apple.frameworks.diskimages skip-verify -bool true
    # defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
    # defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
    
    # Automatically open a new Finder window when a volume is mounted
    # defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    # defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    # defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
    
    # Use column view in all Finder windows by default
    # Four-letter codes for all view modes: `icnv`, `clmv`, `Flwv`, `Nlsv`
    defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
    
    # Disable the warning before emptying the Trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool false
    
    # Enable AirDrop over Ethernet and on unsupported Macs running Lion
    # defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
    
    # Expand the following File Info panes:
    # “General”, “Open with”, and “Sharing & Permissions”
    defaults write com.apple.finder FXInfoPanesExpanded -dict \
    	General -bool true \
    	OpenWith -bool true \
    	Privileges -bool true
    
    ###############################################################################
    # Dock, Dashboard, and hot corners                                            #
    ###############################################################################
    
    # Position dock on the left side of the screen
    # defaults write com.apple.dock orientation -string "left"
    
    # Automatically hide and show the Dock
    # defaults write com.apple.dock autohide -bool true
    
    # Enable highlight hover effect for the grid view of a stack (Dock)
    # defaults write com.apple.dock mouse-over-hilite-stack -bool true
    
    # Set the icon size of Dock items to 72 pixels
    # defaults write com.apple.dock tilesize -int 72
    
    # Enable spring loading for all Dock items
    # defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
    
    # Show indicator lights for open applications in the Dock
    # defaults write com.apple.dock show-process-indicators -bool true
    
    # Speed up Mission Control animations
    # defaults write com.apple.dock expose-animation-duration -float 0.1
    
    # Disable Dashboard
    defaults write com.apple.dashboard mcx-disabled -bool true
    
    # Don’t show Dashboard as a Space
    defaults write com.apple.dock dashboard-in-overlay -bool true
    
    # Don’t automatically rearrange Spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false
    
    # Remove the auto-hiding Dock delay
    defaults write com.apple.dock autohide-delay -float 0
    
    # Make Dock icons of hidden applications translucent
    defaults write com.apple.dock showhidden -bool true
    
    # Reset Launchpad, but keep the desktop wallpaper intact
    # find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete
    
    # Add a spacer to the left side of the Dock (where the applications are)
    # defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
    
    # Add a spacer to the right side of the Dock (where the Trash is)
    # defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'
    
    # Hot corners
    # Possible values:
    #  0: no-op
    #  2: Mission Control
    #  3: Show application windows
    #  4: Desktop
    #  5: Start screen saver
    #  6: Disable screen saver
    #  7: Dashboard
    # 10: Put display to sleep
    # 11: Launchpad
    # 12: Notification Center
    # Top left screen corner → Mission Control
    # defaults write com.apple.dock wvous-tl-corner -int 2
    # defaults write com.apple.dock wvous-tl-modifier -int 0
    # Top right screen corner → Desktop
    # defaults write com.apple.dock wvous-tr-corner -int 4
    # defaults write com.apple.dock wvous-tr-modifier -int 0
    # Bottom right screen corner → Display sleep
    # defaults write com.apple.dock wvous-br-corner -int 10
    # defaults write com.apple.dock wvous-br-modifier -int 0
    
    ###############################################################################
    # Safari & WebKit                                                             #
    ###############################################################################
    
    # Privacy: don’t send search queries to Apple
    # defaults write com.apple.Safari UniversalSearchEnabled -bool false
    # defaults write com.apple.Safari SuppressSearchSuggestions -bool true
    
    # Press Tab to highlight each item on a web page
    # defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
    # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
    
    # Show the full URL in the address bar (note: this still hides the scheme)
    # defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
    
    # Set Safari’s home page to `about:blank` for faster loading
    # defaults write com.apple.Safari HomePage -string "about:blank"
    
    # Prevent Safari from opening ‘safe’ files automatically after downloading
    # defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
    
    # Allow hitting the Backspace key to go to the previous page in history
    # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true
    
    # Hide Safari’s bookmarks bar by default
    # defaults write com.apple.Safari ShowFavoritesBar -bool false
    
    # Hide Safari’s sidebar in Top Sites
    # defaults write com.apple.Safari ShowSidebarInTopSites -bool false
    
    # Disable Safari’s thumbnail cache for History and Top Sites
    # defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
    
    # Enable Safari’s debug menu
    # defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
    
    # Make Safari’s search banners default to Contains instead of Starts With
    # defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
    
    # Enable the Develop menu and the Web Inspector in Safari
    # defaults write com.apple.Safari IncludeDevelopMenu -bool true
    # defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
    
    # Add a context menu item for showing the Web Inspector in web views
    # defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
    
    # Enable continuous spellchecking
    # defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
    
    # Disable auto-correct
    # defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false
    
    # Disable AutoFill
    # defaults write com.apple.Safari AutoFillFromAddressBook -bool false
    # defaults write com.apple.Safari AutoFillPasswords -bool false
    # defaults write com.apple.Safari AutoFillCreditCardData -bool false
    # defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
    
    # Warn about fraudulent websites
    # defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
    
    # Disable plug-ins
    # defaults write com.apple.Safari WebKitPluginsEnabled -bool false
    # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false
    
    # Disable Java
    # defaults write com.apple.Safari WebKitJavaEnabled -bool false
    # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
    
    # Block pop-up windows
    # defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
    # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

    # Enable “Do Not Track”
    # defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

    # Update extensions automatically
    # defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

    ###############################################################################
    # Mail                                                                        #
    ###############################################################################

    # Disable send and reply animations in Mail.app
    # defaults write com.apple.mail DisableReplyAnimations -bool true
    # defaults write com.apple.mail DisableSendAnimations -bool true

    # Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
    defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

    # Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
    # defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\\U21a9"

    # Display emails in threaded mode, sorted by date (oldest at the top)
    # defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
    # defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
    # defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

    # Disable inline attachments (just show the icons)
    # defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

    # Disable automatic spell checking
    # defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"

    ###############################################################################
    # Time Machine                                                                #
    ###############################################################################

    # Prevent Time Machine from prompting to use new hard drives as backup volume
    # defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    ###############################################################################
    # Activity Monitor                                                            #
    ###############################################################################

    # Show the main window when launching Activity Monitor
    # defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

    # Visualize CPU usage in the Activity Monitor Dock icon
    # defaults write com.apple.ActivityMonitor IconType -int 5

    # Show all processes in Activity Monitor
    # defaults write com.apple.ActivityMonitor ShowCategory -int 0

    # Sort Activity Monitor results by CPU usage
    # defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
    # defaults write com.apple.ActivityMonitor SortDirection -int 0

    ###############################################################################
    # Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
    ###############################################################################

    # Enable the debug menu in Address Book
    # defaults write com.apple.addressbook ABShowDebugMenu -bool true

    # Use plain text mode for new TextEdit documents
    # defaults write com.apple.TextEdit RichText -int 0

    # Open and save files as UTF-8 in TextEdit
    # defaults write com.apple.TextEdit PlainTextEncoding -int 4
    # defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

    # Enable the debug menu in Disk Utility
    defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
    defaults write com.apple.DiskUtility advanced-image-options -bool true

    # Auto-play videos when opened with QuickTime Player
    # defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

    ###############################################################################
    # Mac App Store                                                               #
    ###############################################################################

    # Enable the WebKit Developer Tools in the Mac App Store
    # defaults write com.apple.appstore WebKitDeveloperExtras -bool true

    # Enable Debug Menu in the Mac App Store
    # defaults write com.apple.appstore ShowDebugMenu -bool true

    # Disable the automatic update check
    # defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false

    # Check for software updates daily, not just once per week
    # defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

    # Download newly available updates in background
    # defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

    # Install System data files & security updates
    # defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

    # Automatically download apps purchased on other Macs
    # defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

    # Turn on app auto-update
    # defaults write com.apple.commerce AutoUpdate -bool true

    # Allow the App Store to reboot machine on macOS updates
    # defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

    ###############################################################################
    # Photos                                                                      #
    ###############################################################################

    # Prevent Photos from opening automatically when devices are plugged in
    # defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

    ###############################################################################
    # Messages                                                                    #
    ###############################################################################

    # Disable automatic emoji substitution (i.e. use plain text smileys)
    # defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

    # Disable smart quotes as it’s annoying for messages that contain code
    # defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

    # Disable continuous spell checking
    # defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

    ###############################################################################
    # Google Chrome & Google Chrome Canary                                        #
    ###############################################################################

    # Disable the all too sensitive backswipe on trackpads
    # defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
    # defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

    # Disable the all too sensitive backswipe on Magic Mouse
    # defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
    # defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

    # Use the system-native print preview dialog
    defaults write com.google.Chrome DisablePrintPreview -bool true
    defaults write com.google.Chrome.canary DisablePrintPreview -bool true

    # Expand the print dialog by default
    defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
    defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

    ###############################################################################
    # Opera & Opera Developer                                                     #
    ###############################################################################

    # Expand the print dialog by default
    # defaults write com.operasoftware.Opera PMPrintingExpandedStateForPrint2 -boolean true
    # defaults write com.operasoftware.OperaDeveloper PMPrintingExpandedStateForPrint2 -boolean true

    ###############################################################################
    # Extras
    ###############################################################################

    # Activate audible chime when power cable is plugged in.
    # defaults write com.apple.PowerChime ChimeOnAllHardware -bool true; open /System/Library/CoreServices/PowerChime.app


    ```
  
1. Update system

    - `sudo softwareupdate -i -a`
    
1. Install Xcode CLT

   ```
   xcode-select --install
   sudo xcodebuild -license accept
   installer -package /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target \
   ```
    
    
1. Install Xcode & configure Xcode

    - Use GUI...
    
1. Prepare /opt

    ```
    sudo mkdir /opt
    sudo chgroup -R staff /opt/
    sudo chmod -R g+w /opt/
    ```

1. Install Intel Compilers

    - Log in: https://software.intel.com/en-us/user/login?destination=node/790487

    ```
    mkdir /opt/intel/
    pushd /opt/intel/
    curl -LO "http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/14903/m_pythoni3_p_2019.1.056.tar.gz"
    tar -xvzf m_pythoni3_p_2019.1.056.tar.gz
    mv m_pythoni3_p_2019.1.056.tar.gz ~/.Trash
    bash intelpython3 setup_intel_python.sh
    
    curl -LO "http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/14903/m_pythoni2_p_2019.1.056.tar.gz"
    tar -xvzf m_pythoni2_p_2019.1.056.tar.gz
    mv m_pythoni2_p_2019.1.056.tar.gz ~/.Trash
    bash intelpython2 setup_intel_python.sh
    popd
    ```
    
    - Add to logon script:
    
    ```
    source /opt/intel/intelpython3/bin/activate root
    source /opt/intel/intelpython3/bin/activate root
    ```
    
    - Continue install
    
    ```
    curl -LO "http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/14826/m_ccompxe_2019.1.034.dmg"
    hdiutil attach m_ccompxe_2019.1.0.34.dmg
    open /Volumes/m_ccompxe_2019.1.034/m_ccompxe_2019.1.034.app/
    read "Press Return (Enter) to continue"
    hdiutil detach /Volumes/m_ccompxe_2019.1.034
    mv m_ccompxe_2019.1.0.34.dmg ~/.Trash
    
    curl -LO "http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/14828/m_fcompxe_2019.1.034.dmg"
    hdiutil attach m_fcompxe_2019.1.034.dmg
    open /Volumes/m_fcompxe_2019.1.034/m_fcompxe_2019.1.034.app/
    read "Press Return (Enter) to continue"
    hdiutil detach /Volumes/m_fcompxe_2019.1.034
    mv m_fcompxe_2019.1.0.34.dmg ~/.Trash


    source /opt/intel/bin/compilervars.sh intel64

1. Install Golang

    ```
    curl -LO "https://dl.google.com/go/go1.11.2.darwin-amd64.pkg"
    install_pkg go1.11.2.darwin-arm64.pkg
    mv go1.11.2.darwin-arm64.pkg ~/.Trash
    ```

1. Install GPGtools

    ```
    curl -LO "https://releases.gpgtools.org/GPG_Suite-2018.5.dmg"
    hdiutil attach GPG_Suite-2018.5.dmg
    install_pkg /Volumes/GPG\ Suite/Install.pkg
    hdiutil detach /Volumes/GPG\ Suite/
    mv GPG_Suite-2018.5.dmg ~/.Trash
    ```

1. Update Python

    ```
    curl -LO "https://www.python.org/ftp/python/3.7.1/python-3.7.1-macosx10.9.pkg"
    install_pkg python-3.7.1-macosx10.9.pkg
    mv python-3.7.1-macosx10.9.pkg ~/.Trash

    curl -LO "https://www.python.org/ftp/python/2.7.15/python-2.7.15-macosx10.9.pkg"
    install_pkg python-2.7.15-macosx10.9.pkg
    mv python-2.7.15-macosx10.9.pkg ~/.Trash
    ```

1. Install pkgsrc

    ```
    pushd /opt
    git clone https://github.com/NetBSD/pkgsrc.git -b trunk --single-branch
    pushd /opt/pkgsrc/bootstrap
    sh bootstrap
    export PKG_ROOT=/opt/pkg/
    mkdir ${PKG_ROOT}{work,distfiles}
    
    # Edit mk.conf
    #WRKOBJDIR=/opt/pkg/work
    #DISTDIR=/opt/pkg/distfiles
    
    popd
    ```
    

1. Install Spack

    ```
    pushd /opt
    git clone https://github.com/spack/spack.git
    export SPACK_ROOT=/opt/spack
    export PATH=$SPACK_ROOT/bin:$PATH
    source $SPACK_ROOT/share/spack/setup-env.sh
    spack compiler find
    spack gpg init
    popd
    ```
  
1. Install Macports?
    
    ```
    curl -LO https://github.com/macports/macports-base/releases/download/v2.5.4/MacPorts-2.5.4-10.14-Mojave.pkg
    

1. ...


```
function install_pkg {
    #TODO: error checking...
    pkgutil --check-signature $1 && \
    sudo installer -package $1 -target / || \
    echo "Install failed: " "${1}"
}

curl -L -o "jre-8u191-macosx-x64.dmg" "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=235718_2787e4a523244c269598db4e85c51e0c"
hdiutil attach jre-8u191-macosx-x64.dmg
open /Volumes/Java\ 8\ Update\ 191/Java\ 8\ Update\ 191.app/
read -p "Press Enter (Return) when complete"
hdiutil detach /Volumes/Java\ 8\ Update\ 191/
mv jre-8u191-macosx-x64.dmg ~/.Trash

curl -LO "https://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_osx-x64_bin.dmg"
hdiutil attach jdk-11.0.1_osx-x64_bin.dmg
install_pkg /Volumes/JDK\ 11.0.1/JDK\ 11.0.1.pkg
hdiutil detach /Volumes/JDK\ 11.0.1/
mv jdk-11.0.1_osx-x64_bin.dmg ~/.Trash

curl -L -o Visual_Paradigm.dmg "https://www.visual-paradigm.com/download/community.jsp?platform=macosx&arch=jre"
hdiutil attach Visual_Paradigm.dmg
cp "/Volumes/Visual Paradigm CE/Visual Paradigm.app" /Applications/
hdiutil detach "/Volumes/Visual Paradigm CE"
mv Visual_Paradigm.dmg ~/.Trash

curl -LO "https://github.com/onivim/oni/releases/download/v0.3.6/Oni-0.3.6-osx.dmg"
hdiutil attach Oni-0.3.6-osx.dmg
cp -R /Volumes/Oni\ 0.3.6/Oni.app /Applications
hdiutil detach /Volumes/Oni\ 0.3.6/
mv Oni-0.3.6-osx.dmg ~/.Trash

curl -LO "https://officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/OfficeMac/Microsoft_Office_16.19.18110915_Installer.pkg"
install_pkg Microsoft_Office_16.19.18110915_Installer.pkg
mv Microsoft_Office_16.19.18110915_Installer.pkg ~/.Trash

curl -LO "https://download.microsoft.com/download/D/0/5/D055DA17-C7B8-4257-89A1-78E7BBE3833F/SkypeForBusinessInstaller-16.23.0.64.pkg"
install_pkg SkypeForBusinessInstaller-16.23.0.64.pkg
mv SkypeForBusinessInstaller-16.23.0.64.pkg ~/.Trash
```
