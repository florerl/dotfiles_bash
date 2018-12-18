#!/usr/bin

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

PLATFORM="macOS_10.14"
# Instal Xcode CLT
xcode-select --install
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
install_pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_${PLATFORM}.pkg 
unset PLATFORM

# Install GitHub Desktop

cd $HOME/Downloads
cd /Applications/
curl -LO "https://central.github.com/deployments/desktop/desktop/latest/darwin"

# Install GPG(tools)
VERSION=$(curl -s "https://gpgtools.org" | egrep -o "https://releases.gpgtools.org/GPG_Suite-[0-9]+\.[0-9]+" | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+"
VERSION=${VERSION:-"2018.5"}
curl -L -o "GPG_Suite.dmg" "https://releases.gpgtools.org/GPG_Suite-${VERSION}.dmg"
hdiutil attach GPG_Suite.dmg
install_pkg /Volumes/GPG\ Suite/Install.pkg
hdiutil detach /Volumes/GPG\ Suite/
trash GPG_Suite.dmg
unset VERSION
eval `/usr/libexec/path_helper -s`

# Install Intel Compilers
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

# Install CMake
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

# Install Golang
PLATFORM="darwin-amd64"
VERSION=$(curl "https://golang.org/dl/" | egrep -o "https://dl.google.com/go/go[0-9]+\.[0-9]+\.[0-9]+\.${PLATFORM}\.pkg" | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+\.[0-9]+")
VERSION=${VERSION:-"1.11.2"}
curl -L -o go.pkg "https://dl.google.com/go/go${VERSION}.${PLATFORM}.pkg"
install_pkg go.pkg
trash go.pkg
unset VERSION PLATFORM
eval `/usr/libexec/path_helper -s`

# Install Java
# Open in Safari to accept OTNLA
VERSION=${VERSION:-"11.0.1"}
PLATFORM="osx-x64"
open "https://www.oracle.com/technetwork/java/javase/downloads/jdk11-downloads-5066655.html" 
read -p "Press Enter (Return) when complete"
hdiutil attach jdk-${VERSION}_${PLATFORM}_bin.dmg
install_pkg "/Volumes/JDK ${VERSION}/JDK ${VERSION}.pkg"
hdiutil detach "/Volumes/JDK ${VERSION}/"
trash jdk-${VERSION}_${PLATFORM}_bin.dmg
unset VERSION PLATFORM
eval `/usr/libexec/path_helper -s`

# Update Python
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

# Update Ruby
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

# Install NodeJS
VERSION=$(curl -sSL https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')
curl -L -o "node.pkg" "https://nodejs.org/dist/latest/node-${VERSION}.pkg" \ &&
install_pkg "node.pkg"
trash "node.pkg"
unset VERSION PLATFORM
eval `/usr/libexec/path_helper -s`

# Install R
VERSION=$(curl -sSL http://cran.cnr.berkeley.edu/bin/macosx/ | egrep -o "R-[0-9]+\.[0-9]+\.[0-9]+.pkg" | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+\.[0-9]+")
VERSION=${VERSION:-"3.5.1"}

curl -L -o "R.pkg" "http://cran.cnr.berkeley.edu/bin/macosx/R-${VERSION}.pkg"
install_pkg "R.pkg"
trash "R.pkg"
unset VERSION
eval `/usr/libexec/path_helper -s`

# Install RStudio
VERSION=$(curl -sSL https://www.rstudio.com/products/rstudio/download/ | egrep -o "RStudio-[0-9]+\.[0-9]+\.[0-9]+\.dmg" | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+\.[0-9]+")
VERSION=${VERSION:-1.1.463}

curl -L -o "RStudio.dmg" "https://download1.rstudio.org/RStudio-${VERSION}.dmg"
hdiutil mount RStudio.dmg
cp -R /Volumes/RStudio-${VERSION}/RStudio.app /Applications/
hdiutil detach /Volumes/RStudio-${VERSION}
trash RStudio.dmg
unset VERSION

# Install MacTeX
curl -LO "http://tug.org/cgi-bin/mactex-download/MacTeX.pkg"
install_pkg MacTeX.pkg
trash MacTeX.pkg

# Install Macports
PLATFORM="10.14-Mojave"
VERSION=$(curl -sSL https://github.com/macports/macports-base/releases/latest | egrep -o "MacPorts-[0-9]+\.[0-9]+\.[0-9]+-${PLATFORM}\.pkg | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+\.[0-9]+")
VERSION=${VERSION:-2.5.4}
curl -L -o "MacPorts.pkg" "https://github.com/macports/macports-base/releases/latest/download/v${VERSION}/MacPorts-${VERSION}-${PLATFORM}.pkg"
install_pkg MacPorts.pkg
trash MacPorts.pkg
unset VERSION PLATFORM

# Install Homebrew
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

cd /opt
# Install pkgsrc
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

cd /opt
# Install Spack
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

cd $HOME/Downloads
# Install Visual Paradigm
curl -L -o Visual_Paradigm.dmg "https://www.visual-paradigm.com/download/community.jsp?platform=macosx&arch=jre"
hdiutil attach Visual_Paradigm.dmg
cp "/Volumes/Visual Paradigm CE/Visual Paradigm.app" /Applications/
hdiutil detach "/Volumes/Visual Paradigm CE"
trash Visual_Paradigm.dmg 

# Install Oni
VERSION=$(curl -sSL "https://github.com/onivim/oni/releases/latest" | egrep -o "Oni-[0-9]+\.[0-9]+\.[0-9]+-osx.dmg | sort -Vr | egrep -m 1 -o "[0-9]+\.[0-9]+\.[0-9]+")
VERSION=${VERSION:-0.3.6}
curl -L -o Oni.dmg "https://github.com/onivim/oni/releases/download/v${VERSION}/Oni-${VERSION}-osx.dmg"
hdiutil attach Oni.dmg
cp -R /Volumes/Oni\ ${VERSION}/Oni.app /Applications
hdiutil detach /Volumes/Oni\ $VERSION/
trash Oni-0.3.6-osx.dmg

curl -L -o "MS_Office.pkg" "https://officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/OfficeMac/Microsoft_Office_16.19.18110915_Installer.pkg"
install_pkg MS_Office.pkg
trash MS_Office.pkg

curl -LO "https://download.microsoft.com/download/D/0/5/D055DA17-C7B8-4257-89A1-78E7BBE3833F/SkypeForBusinessInstaller-16.23.0.64.pkg"
install_pkg SkypeForBusinessInstaller-16.23.0.64.pkg
trash SkypeForBusinessInstaller-16.23.0.64.pkg
