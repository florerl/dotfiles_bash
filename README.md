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
    sudo chgroup staff /opt
    ```

1. Install Intel Compilers

    - Log in

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

1. Install Spack

    ```
    cd /opt
    git clone https://github.com/spack/spack.git
    export SPACK_ROOT=/opt/spack
    export PATH=$SPACK_ROOT/bin:$PATH
    source $SPACK_ROOT/share/spack/setup-env.sh
    spack compiler find
    spack gpg init
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
