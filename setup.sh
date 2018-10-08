#! /bin/bash
STARTDIR="$PWD"
continueok() {
  read -p "If all went well, press return to continue. Otherwise, ctrl+c to quit."
  echo "OK."
}

continuesure() {
  read -p "Is this OK?"
  echo "OK."
}

echo "Setting up a new profile. You will need to enter the root password once."
echo "After that, we will be using sudo and therefore you be able to use your user"
echo "password instead."
echo "Your user's name: ""$USER"
echo "Running su to install sudo and add ""$USER""to the 'sudo' group on the machine."
echo "Please enter the root password when prompted."
set -x
su -c 'apt-get -y install sudo; adduser '"$USER"' sudo'
set +x
echo "If all went well, we should have sudo installed and the user ""$USER"
echo "should be granted permission to use it."
continueok
echo "First, running apt-get update to make sure we aren't going to hit 404's"
echo "due to an out-of-date database."
set -x
sudo apt-get update
set +x
continueok
echo "Installing ksh, FVWM, stalonetray, hsetroot, xterm, rxvt, and compton (the bare"
echo "essentials)."
set -x
sudo apt-get -y install ksh fvwm stalonetray hsetroot compton xterm rxvt
set +x
continueok
echo "Installing x11-apps (for xwd/xclock), x11-server-utils (xsetroot),  and"
echo "imagemagick for use with my screenshot-taking GUI program (xwdui). Also"
echo "installing both versions of Python, of which only one version (2) is strictly"
echo "necessary, but it's good to have both."
set -x
sudo apt-get -y install x11-apps imagemagick x11-server-utils python python3 python-tk python3-tk
set +x
continueok
echo "Installing further dependencies of my init scripts. These include xindkeys,"
echo "pnmixer, nm-tray (network-manager tray applet), mate-power-manager/mate-terminal"
echo "(and the rest of MATE unfortunately... My environment could use some"
echo "trimming here)."
set -x
sudo apt-get -y install xbindkeys pnmixer nm-tray mate-power-manager mate-terminal
set +x
continueok
echo "Installing SCIM (input method software) and scim-anthy (for CJK input)."
set -x
sudo apt-get -y install scim scim-gtk-immodule scim scim-im-agent scim-anthy scim-modules-table scim-modules-socket scim-tables-ja libscim8v5 libanthy1 libanthyinput0 anthy anthy-common kasumi
set +x
continueok
echo "Installing GNU Unifont (a font I like)."
set -x
sudo apt-get -y install ttf-unifont unifont psf-unifont xfonts-unifont
set +x
continueok
echo "Installing xvkbd (on-screen keyboard I mostly like) and xdotool (for"
echo "automating tasks)."
set -x
sudo apt-get -y install xvkbd xdotool
set +x
continueok
echo "Installing mcomix, my favorite image viewer."
set -x
sudo apt-get -y install mcomix
set +x
continueok
echo "Installing Mozilla Firefox, a decent browser until I can get Seamonkey built."
set -x
sudo apt-get -y install firefox
set +x
continueok
echo "Installing some more development-oriented stuff (emacs, binutils, gcc, diff, git,"
echo "subversion, mercurial, perl, ssh, curl, wget, GNU make, cmake,"
echo "build-essential, debian devscripts, autoconf, m4, libstdc++6,"
echo "OpenGL (MESA) stuff, X11 stuff, libxml, curses, some compression software,"
echo "development headers for common libraries, etc)."
echo "This will likely take a while. It's a LOT of stuff."
set -x
sudo apt-get -y install git subversion binutils gcc g++ libsdl-image1.2-dev \
     libsdl-mixer1.2-dev libsdl-sound1.2-dev libsdl-ttf2.0-dev libsdl1.2-dev \
     libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev \
     libgtk2.0-dev libgtk-3-dev libgtk2-perl libgtk3-perl libgtk2.0-bin \
     libgtk-3-bin libgtk2.0-common libgtk-3-common libgtkglext1-dev \
     libgtksourceview2.0-dev perl perl-base perl-tk openssh-client \
     openssh-server sshfs emacs curl libcurl3 libcurl3-gnutls \
     libcurl4-gnutls-dev wget build-essential make cmake automake devscripts \
     autoconf m4 libstdc++6 libxcb-glx0-dev libva-glx2 libglx-mesa0 libglx0 \
     libglu1-mesa-dev libglew-dev libglapi-mesa libgl1-mesa-dri \
     libgl1-mesa-dev libgl1-mesa-glx freeglut3-dev x11proto-gl-dev \
     libx11-xcb-dev libxcb-xfixes0-dev libxcb-util0 libxcb-sync-dev \
     libxcb-shm0-dev libxcb-shape0-dev libxcb-render0-dev libxcb-randr0-dev \
     libxcb-present-dev libxcb-keysyms1 libxcb-image0 libxcb-dri3-dev \
     libxcb-dri2-0-dev libxcb1-dev libxext-dev libxfixes-dev libxfont-dev \
     libxi-dev libxinerama-dev libxkbcommon-dev libxkbfile-dev libxmu-dev \
     libxmuu-dev libxrandr-dev libxrender-dev libxshmfence-dev libxss-dev \
     libxres-dev libxt-dev libxtst-dev libxxf86dga-dev libxf86vm-dev \
     libxft-dev libxdmcp-dev libxdamage-dev libxcursor-dev libxcomposite-dev \
     libxau-dev libx11-dev libx11-xcb-dev libxv-dev libxml2-dev \
     libncurses-dev libncurses5-dev libncursesw5-dev libncurses6 libncursesw6 \
     libtinfo-dev zlib1g-dev xz-utils liblzma-dev p7zip-full libarchive-dev \
     zip unzip 
 set +x
continueok
echo "Installing some multimedia programs, tools, libraries, and development"
echo "headers."
set -x
sudo apt-get install libx264-dev libx265-dev libfdk-aac-dev libogg-dev \
     libvorbis-dev libtheora-dev libspeex-dev libvpx-dev libflac-dev flac \
     libopus-dev libass-dev libasound2-dev alsa-oss gimp alsa-utils \
     libgme-dev libmp3lame-dev libxvidcore-dev libgstreamer1.0-dev \
     libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev \
     mpv i965-va-driver libvdpau-va-gl1 libtwolame-dev libwebp-dev zlib1g-dev \
     libdvdnav-dev libdvdread-dev cdparanoia libcdparanoia-dev libcdio-utils \
     cdrdao cue2toc 
     
set +x
continueok
echo "Installing system management tools (gparted)."
set -x
sudo apt-get install gparted
set +x
continueok


echo "Copying home directory skeleton into your new home directory."
echo "Existing files WILL BE OVERWRITTEN. Is that OK?"
continuesure
echo "I'm going to ask one more time, just to make certain."
continuesure
echo "Sorry about that, just can't be too careful. Copying over."
# copy all files and dotfiles that use common characters
# this doesn't include all possible dotfiles, but pretty much any one in
# actual usage by me.
set -x
cd "$STARTDIR""/wyatt"
tar -c -f - * .[A-Z]* .[0-9]* .[a-z]* | tar -C "$HOME" -x -v -f -
cd "$HOME/"".config"
ln -s "$HOME""/.fvwm/config" "fvwm"
set +x
echo "Reminder: You may want to install a dvdcss library"
echo "(not in the debian repositories) before trying to do anything like"
echo "building ffmpeg or mplayer from sources."
