# dotfiles
## Bootstrap ToDo:
1. Set name (sudo required, authorization)
    - `sudo sciutil --set ComputerName $HOST`
    - `sudo sciutil --set HostName $HOST`
    - `sudo sciutil --set LocalHostName $HOST`
    - `exec bash -l`
1. Enable location services (sudo required, hidden from User)
    - `sudo defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1`
    - `chown -R _locationd:_locationd /var/db/locationd`
1. Enable automatic timezone update
    - `defaults write /Library/Preferences/com.apple.timezone.auto Active -bool true`
    - `defaults write /Library/Preferences/com.apple.locationmenu ShowSystemServices -bool true`
    
1. Install Xcode CLT
    - `xcode-select --install`
1. Install Xcode & configure Xcode
    - Use GUI...
1. ...

`function install_pkg {`

`    #TODO: error checking...`

`    pkgutil --check-signature $1 && \`

`    sudo installer -package $1 -target / || \`

`    echo "Install failed: " "${1}"`

`}`


`curl -LO "https://releases.gpgtools.org/GPG_Suite-2018.5.dmg"`

`hdiutil attach GPG_Suite-2018.5.dmg`

`install_pkg /Volumes/GPG\ Suite/Install.pkg`

`hdiutil detach /Volumes/GPG\ Suite/`


`curl -LO "https://www.python.org/ftp/python/3.7.1/python-3.7.1-macosx10.9.pkg"`

`install_pkg python-3.7.1-macosx10.9.pkg`

`rm python-3.7.1-macosx10.9.pkg`


`curl -LO "https://www.python.org/ftp/python/2.7.15/python-2.7.15-macosx10.9.pkg"`

`install_pkg python-2.7.15-macosx10.9.pkg`

`rm python-2.7.15-macosx10.9.pkg`


`curl -L -o "jre-8u191-macosx-x64.dmg" "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=235718_2787e4a523244c269598db4e85c51e0c"`

`hdiutil attach jre-8u191-macosx-x64.dmg`

`open /Volumes/Java\ 8\ Update\ 191/Java\ 8\ Update\ 191.app/`

`read -p "Press Enter (Return) when complete"`

`hdiutil detach /Volumes/Java\ 8\ Update\ 191/`


`curl -LO "https://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_osx-x64_bin.dmg"`

`hdiutil attach jdk-11.0.1_osx-x64_bin.dmg`

`install_pkg /Volumes/JDK\ 11.0.1/JDK\ 11.0.1.pkg`

`hdiutil detach /Volumes/JDK\ 11.0.1/`


`curl -LO "https://github.com/onivim/oni/releases/download/v0.3.6/Oni-0.3.6-osx.dmg"`

`hdiutil attach Oni-0.3.6-osx.dmg`

`cp -R /Volumes/Oni\ 0.3.6/Oni.app /Applications`

`hdiutil detach /Volumes/Oni\ 0.3.6/`


`curl -LO "https://officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/OfficeMac/Microsoft_Office_16.19.18110915_Installer.pkg"`

`install_pkg Microsoft_Office_16.19.18110915_Installer.pkg`

`rm Microsoft_Office_16.19.18110915_Installer.pkg`


`curl -LO "https://download.microsoft.com/download/D/0/5/D055DA17-C7B8-4257-89A1-78E7BBE3833F/SkypeForBusinessInstaller-16.23.0.64.pkg"`

`install_pkg SkypeForBusinessInstaller-16.23.0.64.pkg`

`rm SkypeForBusinessInstaller-16.23.0.64.pkg`
