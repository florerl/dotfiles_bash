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

## Git submodule

- Add submodule foo/bar to directory bar:

    ```git submodule add https://github.com/foo/bar bar```

- Initializing/checking-out submodule:

    ```git submodule update --init --recursive```

- Upgrading submodule

    ```git submodule update --init --remote```

## Setting up your Mac

If you did all of the above you may now follow these install instructions to setup a new Mac.

1. Update macOS to the latest version with the App Store

1. Install Xcode from the App Store, open it and accept the license agreement

1. Install macOS Command Line Tools by running xcode-select --install

1. Copy your public and private SSH keys to ~/.ssh and make sure they're set to 600

1. Clone this repo to ~/.dotfiles

1. Append /usr/local/bin/zsh to the end of your /etc/shells file

1. Run install.sh to start the installation

1. Restore preferences by running mackup restore

1. Restart your computer to finalize the process

Your Mac is now ready to use!



## Bootstrap ToDo:

1. Set misc. system settings

    ```
      # Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
      # all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
    #rm -rf ~/Library/Application Support/Dock/desktoppicture.db
    #sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
    #sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg
    ```
     
1. Install Xcode CLT

   ```
   PLATFORM="macOS_10.14"
   xcode-select --install
   sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -license accept
   install_pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_${PLATFORM}.pkg 
   unset PLATFORM
   ```
    
    
1. Install Xcode & configure Xcode for GitHub

    - Use GUI...
    
1. Prepare /opt

    ```
    sudo mkdir /opt
    sudo chgroup -R staff /opt/
    sudo chmod -R g+w /opt/
    ```

1. Install GPGtools

    ```
    VERSION=$(curl -s "https://gpgtools.org" | egrep -o "https://releases.gpgtools.org/GPG_Suite-[0-9]+\.[0-9]+" | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+"
    VERSION=${VERSION:-"2018.5"}
    PLATFORM=""
    curl -L -o "GPG_Suite.dmg" "https://releases.gpgtools.org/GPG_Suite-${VERSION}.dmg"
    hdiutil attach GPG_Suite.dmg
    install_pkg /Volumes/GPG\ Suite/Install.pkg
    hdiutil detach /Volumes/GPG\ Suite/
    trash GPG_Suite.dmg
    unset VERSION PLATFORM
    eval `/usr/libexec/path_helper -s`
    ```

1. Install GitHub Desktop

    ```
    cd /Applications/
    curl -LO "https://central.github.com/deployments/desktop/desktop/latest/darwin"

1. Install Intel Compilers

    - Log in: https://software.intel.com/en-us/user/login?destination=node/790487

    ```
    open "https://software.intel.com/en-us/user/login"
    read "Press Return (Enter) to continue"
    VERSION="2019.1.0.34"
    VERSIONF="2019.1.034"
    CVAL="14826"
    FVAL="14828"
    PLATFORM=""
    curl -L -o "m_ccompxe.dmg" "http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/${CVAL}/m_ccompxe_${VERSION}.dmg"
    hdiutil attach m_ccompxe.dmg
    open /Volumes/m_ccompxe_${VERSIONF}/m_ccompxe_${VERSIONF}.app/
    read "Press Return (Enter) to continue"
    hdiutil detach /Volumes/m_ccompxe_${VERSIONF}
    trash m_ccompxe.dmg
    
    curl -L -o "m_fcompxe.dmg" "http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/${FVAL}/m_fcompxe_${VERSION}.dmg"
    hdiutil attach m_fcompxe.dmg
    open /Volumes/m_fcompxe_${VERSIONF}/m_fcompxe_${VERSIONF}.app/
    read "Press Return (Enter) to continue"
    hdiutil detach /Volumes/m_fcompxe_${VERSIONF}
    trash m_fcompxe.dmg

    source /opt/intel/bin/compilervars.sh intel64
    unset VERSION VERSIONF CVAL FVAL PLATFORM
    eval `/usr/libexec/path_helper -s`
    ```

1. Install CMake
    ```
    VERSION=$(curl "https://github.com/Kitware/CMake/releases" | egrep -o "cmake-[0-9]+\.[0-9]+\.[0-9]+-.*\.dmg" | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+\.[0-9]+")
    VERSION=${VERSION:-"3.13.1"}
    PLATFORM="Darwin-x86_64"
    curl -L -o "cmake.dmg" "https://github.com/Kitware/CMake/releases/download/v${VERSION}/cmake-${VERSION}-${PLATFORM}.dmg"
    hdiutil attach cmake.dmg
    cp -R "/Volumes/cmake-${VERSION}-${PLATFORM}/CMake.app" /Applications
    hdiutil detach /Volumes/cmake-${VERSION}-${PLATFORM}
    trash cmake.dmg
    sudo tee /etc/paths.d/cmake << EOF
    /Applications/CMake.app/Contents/bin
    EOF
    unset VERSION PLATFORM
    eval `/usr/libexec/path_helper -s`

    ```

1. Install Golang

    ```
    PLATFORM="darwin-amd64"
    VERSION=$(curl "https://golang.org/dl/" | egrep -o "https://dl.google.com/go/go[0-9]+\.[0-9]+\.[0-9]+\.${PLATFORM}\.pkg" | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+\.[0-9]+")
    VERSION=${VERSION:-"1.11.2"}
    curl -L -o go.pkg "https://dl.google.com/go/go${VERSION}.${PLATFORM}.pkg"
    install_pkg go.pkg
    trash go.pkg
    unset VERSION PLATFORM
    eval `/usr/libexec/path_helper -s`

    ```

1. Install Java

    ```
    # Open in Safari to accept OTNLA
    VERSION=${VERSION:-"11.0.1"}
    PLATFORM="osx-x64"
    open "https://www.oracle.com/technetwork/java/javase/downloads/jdk11-downloads-5066655.html" 
    read -p "Press Enter (Return) when complete"
    hdiutil attach jdk-${VERSION}_${PLATFORM}_bin.dmg
    install_pkg "/Volumes/JDK ${VERSION}/JDK ${VERSION}.pkg" \
    hdiutil detach "/Volumes/JDK ${VERSION}/"
    trash jdk-${VERSION}_${PLATFORM}_bin.dmg
    unset VERSION PLATFORM
    eval `/usr/libexec/path_helper -s`
    ```

1. Update Python

    ```
    PLATFORM="macosx10.9"
    VERSION3=$(curl "https://www.python.org/downloads/mac-osx/" | egrep -o "Latest Python 3 Release - Python [0-9]+\.[0-9]+\.[0-9]+" | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+\.[0-9]+")
    VERSION3=${VERSION3:-"3.7.0"}
    VERSION2=$(curl "https://www.python.org/downloads/mac-osx/" | egrep -o "Latest Python 2 Release - Python [0-9]+\.[0-9]+\.[0-9]+" | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+\.[0-9]+")
    VERSION2=${VERSION2:-"$(/usr/bin/python -V 2>&1 | egrep -o '[0-9]+\.[0-9]+\.[0-9]+')"}
    for VERSION in $VERSION3 $VERSION2; do
    curl -L -o python-${VERSION}.pkg "https://www.python.org/ftp/python/${VERSION}/python-${VERSION}-${PLATFORM}.pkg"
      install_pkg python-${VERSION}.pkg
      trash python-${VERSION}.pkg
    done
    unset VERSION VERSION2 VERSION3 PLATFORM
    eval `/usr/libexec/path_helper -s`
    ```

1. Update Ruby

    ```
    # Install mpapis public key (might need `gpg2` and or `sudo`)
    gpg --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    # Download the installer
    curl -LO "https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer"
    curl -LO "https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc"
    # Verify the installer signature (might need `gpg2`), and if it validates...
    gpg --verify rvm-installer.asc &&
    # Run the installer
    sudo bash rvm-installer stable --autolibs=read-fail
    sudo dseditgroup -o edit -a ${USER} -t user rvm
    trash rvm-installer rvm-installer.asc
    unset VERSION PLATFORM
    eval `/usr/libexec/path_helper -s`
    ```

1. Install NodeJS

    ```
    VERSION=$(curl -sSL https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')
    curl -L -o "node.pkg" "https://nodejs.org/dist/latest/node-${VERSION}.pkg" \ &&
    install_pkg "node.pkg"
    trash "node.pkg"
    unset VERSION PLATFORM
    eval `/usr/libexec/path_helper -s`
    ```

1. Install R

    ```
    VERSION=$(curl -sSL http://cran.cnr.berkeley.edu/bin/macosx/ | egrep -o "R-[0-9]+\.[0-9]+\.[0-9]+.pkg" | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+\.[0-9]+")
    VERSION=${VERSION:-"3.5.1"}
    
    curl -L -o "R.pkg" "http://cran.cnr.berkeley.edu/bin/macosx/R-${VERSION}.pkg"
    install_pkg "R.pkg"
    trash "R.pkg"
    unset VERSION
    eval `/usr/libexec/path_helper -s`
    ```
    
    
  1. Install RStudio
  
      ```
      VERSION=$(curl -sSL https://www.rstudio.com/products/rstudio/download/ | egrep -o "RStudio-[0-9]+\.[0-9]+\.[0-9]+\.dmg" | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+\.[0-9]+")
      VERSION=${VERSION:-1.1.463}
      
      curl -L -o "RStudio.dmg" "https://download1.rstudio.org/RStudio-${VERSION}.dmg"
      hdiutil mount RStudio.dmg
      cp -R /Volumes/RStudio-${VERSION}/RStudio.app /Applications/
      hdiutil detach /Volumes/RStudio-${VERSION}
      trash RStudio.dmg
      unset VERSION
      ```
      
1. Install MacTeX

    ```
    curl -LO "http://tug.org/cgi-bin/mactex-download/MacTeX.pkg"
    install_pkg MacTeX.pkg
    trash MacTeX.pkg
    ```

1. Install XQuartz

    ```
    VERSION=$(curl -sSL https://www.xquartz.org/releases/index.html | egrep -o "releases/XQuartz-[0-9]+\.[0-9]+\.[0-9]+\.html" | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+\.[0-9]+")
    VERSION=${VERSION:-2.7.11}
    
    curl -L -o "XQuartz.dmg" "https://dl.bintray.com/xquartz/downloads/XQuartz-${VERSION}.dmg"
    hdiutil mount XQuartz.dmg
    pkg_install /Volumes/XQuartz-${VERSION}/XQuartz.pkg
    hdiutil detach /Volumes/XQuartz-${VERSION}
    trash XQuartz.dmg
    unset VERSION
    ```

1. Install pkgsrc

    ```
    pushd /opt
    git clone https://github.com/NetBSD/pkgsrc.git -b trunk --single-branch
    cd pkgsrc/ && git submodule init && git submodule update
    git submodule add --depth 1 git://wip.pkgsrc.org/pkgsrc-wip.git wip && git submodule update
    cd /opt/pkgsrc/bootstrap
    sh bootstrap
    mkdir /opt/pkg/{work,distfiles}
    pkg_admin -K /opt/pkg/pkgdb fetch-pkg-vulnerabilities
    
    sudo tee /opt/pkg/etc/mk.conf << EOF
    WRKOBJDIR= /opt/pkg/work
    DISTDIR=   /opt/pkg/distfiles
    SU_CMD=    sudo /bin/sh -c
    EOF
    
    popd
    ```
    

1. Install Spack

    ```
    pushd /opt
    git clone https://github.com/spack/spack.git
    export SPACK_ROOT=/opt/spack
    sudo tee /etc/paths.d/spack << EOF
    /opt/spack/bin
    EOF
    eval `/usr/libexec/path_helper -s`
    #source $SPACK_ROOT/share/spack/setup-env.sh
    
    spack compiler find
    spack gpg init
    popd
    ```
  
1. Install Macports?
    
    ```
    VERSION="2.5.4"
    PLATFORM="10.14-Mojave"
    curl -L -o "MacPorts.pkg" "https://github.com/macports/macports-base/releases/download/v${VERSION}/MacPorts-${VERSION}-${PLATFORM}.pkg"
    install_pkg MacPorts.pkg
    trash MacPorts.pkg
    unset VERSION PLATFORM

1. ...


```
function install_pkg {
    #TODO: error checking...
    pkgutil --check-signature "$1" && sudo installer -package "$1" -target / || echo "Install failed: " "${1}"
}

function trash {
  #TODO: error checking...
  for i in $@; do
    mv "$1" ${HOME}/.Trash
  done
}
  
curl -L -o "jre-8u191-macosx-x64.dmg" "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=235718_2787e4a523244c269598db4e85c51e0c"
hdiutil attach jre-8u191-macosx-x64.dmg \
&& open /Volumes/Java\ 8\ Update\ 191/Java\ 8\ Update\ 191.app/
&& read -p "Press Enter (Return) when complete" /
&& hdiutil detach /Volumes/Java\ 8\ Update\ 191/
trash jre-8u191-macosx-x64.dmg

curl -LO "https://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_osx-x64_bin.dmg"
hdiutil attach jdk-11.0.1_osx-x64_bin.dmg
install_pkg /Volumes/JDK\ 11.0.1/JDK\ 11.0.1.pkg
hdiutil detach /Volumes/JDK\ 11.0.1/
trash jdk-11.0.1_osx-x64_bin.dmg

curl -L -o Visual_Paradigm.dmg "https://www.visual-paradigm.com/download/community.jsp?platform=macosx&arch=jre"
hdiutil attach Visual_Paradigm.dmg
cp "/Volumes/Visual Paradigm CE/Visual Paradigm.app" /Applications/
hdiutil detach "/Volumes/Visual Paradigm CE"
trash Visual_Paradigm.dmg 

curl -LO "https://github.com/onivim/oni/releases/download/v0.3.6/Oni-0.3.6-osx.dmg"
hdiutil attach Oni-0.3.6-osx.dmg
cp -R /Volumes/Oni\ 0.3.6/Oni.app /Applications
hdiutil detach /Volumes/Oni\ 0.3.6/
trash Oni-0.3.6-osx.dmg

curl -LO "https://officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/OfficeMac/Microsoft_Office_16.19.18110915_Installer.pkg"
install_pkg Microsoft_Office_16.19.18110915_Installer.pkg
trash Microsoft_Office_16.19.18110915_Installer.pkg

curl -LO "https://download.microsoft.com/download/D/0/5/D055DA17-C7B8-4257-89A1-78E7BBE3833F/SkypeForBusinessInstaller-16.23.0.64.pkg"
install_pkg SkypeForBusinessInstaller-16.23.0.64.pkg
trash SkypeForBusinessInstaller-16.23.0.64.pkg
```
