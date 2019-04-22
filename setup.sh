#! /bin/bash
STARTDIR="$PWD"
continueok() {
  echo "If all went well with the last operation, press Return to continue."
  read -p "Otherwise, press Ctrl+C (^C) to quit."
  echo "OK."
}

continuesure() {
  read -p "Is this OK? (Return to continue, Ctrl+C (^C) to quit)"
  echo "OK."
}

echo "Setting up a new profile. You will need to enter the root password once."
echo "After that, we will be using sudo and therefore you be able to use your user"
echo "password instead."
echo "Your user's name: ""$USER"
echo "Running su to install sudo and add ""$USER""to the 'sudo' group on the machine."
echo "Please enter the _root_ password when prompted."
set -x
su -c 'apt-get -y install sudo; adduser '"$USER"' sudo'
set +x
echo "If all went well, we should have sudo installed and the user ""$USER"
echo "should be granted permission to use it."
echo "Next up: Running apt-get update to make sure we aren't going to hit 404's"
echo "due to an out-of-date database."
continueok
set -x
sudo apt-get update
set +x
echo "Next up:"
echo "Installing ksh, FVWM, stalonetray, hsetroot, xterm, rxvt, and compton (the bare"
echo "essentials)."
continueok
set -x
sudo apt-get install ksh fvwm stalonetray hsetroot compton xterm rxvt
set +x
echo "Next up:"
echo "Installing x11-apps (for xwd/xclock), x11-xserver-utils (xsetroot),  and"
echo "imagemagick for use with my screenshot-taking GUI program (xwdui). Also"
echo "installing both versions of Python, of which only one version (2) is strictly"
echo "necessary right now, but it's good to have both."
continueok
set -x
sudo apt-get install x11-apps imagemagick x11-xserver-utils python python3 python-tk python3-tk
set +x
echo "Next up:"
echo "Installing further dependencies of my init scripts. These include xindkeys,"
echo "pnmixer, nm-tray (network-manager tray applet), mate-power-manager/mate-terminal"
echo "(and the rest of MATE unfortunately... My environment could use some"
echo "trimming here)."
continueok
set -x
sudo apt-get install xbindkeys pnmixer nm-tray mate-power-manager mate-terminal
set +x
echo "Next up:"
echo "Installing SCIM (input method software) and scim-anthy (for CJK input)."
continueok
set -x
sudo apt-get install scim scim-gtk-immodule scim scim-im-agent scim-anthy scim-modules-table scim-modules-socket scim-tables-ja libscim8v5 libanthy1 libanthyinput0 anthy anthy-common kasumi
set +x
echo "Next up:"
echo "Installing GNU Unifont (a font I like)."
continueok
set -x
sudo apt-get install ttf-unifont unifont psf-unifont xfonts-unifont
set +x
echo "Next up:"
echo "Installing xvkbd (on-screen keyboard I mostly like) and xdotool (for"
echo "automating tasks)."
continueok
set -x
sudo apt-get install xvkbd xdotool
set +x
echo "Next up:"
echo "Installing mcomix, my favorite image viewer."
continueok
set -x
sudo apt-get install mcomix
set +x
echo "Next up:"
echo "Installing Mozilla Firefox, a decent browser until I can get Seamonkey built."
continueok
set -x
sudo apt-get install firefox
set +x
echo "Next up:"
echo "Installing some more development-oriented stuff (emacs, binutils, gcc, diff, git,"
echo "subversion, mercurial, perl, ssh, curl, wget, GNU make, cmake,"
echo "build-essential, debian devscripts, autoconf, m4, libstdc++6,"
echo "OpenGL (MESA) stuff, X11 stuff, libxml, curses, some compression software,"
echo "development headers for common libraries, etc)."
echo "This will likely take a while. It's a LOT of stuff."
continueok
set -x
sudo apt-get install git subversion binutils gcc g++ libsdl-image1.2-dev \
     libsdl-mixer1.2-dev libsdl-sound1.2-dev libsdl-ttf2.0-dev libsdl1.2-dev \
     libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev \
     libgtk2.0-dev libgtk-3-dev libgtk2-perl libgtk3-perl libgtk2.0-bin \
     libgtk-3-bin libgtk2.0-common libgtk-3-common libgtkglext1-dev \
     libgtksourceview2.0-dev perl perl-base perl-tk openssh-client \
     openssh-server sshfs emacs curl \
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
     libxres-dev libxt-dev libxtst-dev libxxf86dga-dev libxxf86vm-dev \
     libxft-dev libxdmcp-dev libxdamage-dev libxcursor-dev libxcomposite-dev \
     libxau-dev libx11-dev libx11-xcb-dev libxv-dev libxml2-dev \
     libncurses-dev libncurses5-dev libncursesw5-dev libncurses6 libncursesw6 \
     libtinfo-dev zlib1g-dev xz-utils liblzma-dev p7zip-full libarchive-dev \
     zip unzip 
set +x
echo "Next up:"
echo "Installing Debian source management/packaging tools, and adding Debian's"
echo "source repositories to /etc/sources.list. Combined, this should allow"
echo "for working `dpkg-buildpackage` and `apt-get source`. Also adding"
echo "contrib and non-free to normal debian package repository list."
continueok
set -x
sudo apt-get install dpkg-dev debhelper devscripts
# if the deb-src line for sid doesn't already exist, we need to add it
# this is stolen from another script I wrote ages ago; I forget if the RESULT
# variable means anything here or is left over from the writing of that other
# script. Keeping it for safety.
set +x
# deb:
#SRCLINE="$(grep 'deb ' /etc/apt/sources.list| grep 'sid main' | grep -i debian.org)"
#if [ "$(echo "$SRCLINE" | wc -l)" -gt 1 ]; then
  # we might be specifying [arch=] for our sources. Try to narrow our scope
#  SRCLINE="$(grep 'deb ' /etc/apt/sources.list| grep 'sid main' | grep -i debian.org | grep $(dpkg --print-architecture))"
 # if [ "$(echo "$SRCLINE" | wc -l)" -gt 1 ]; then
  #  echo "Something's wrong - this script can't figure out what line to add"
   # echo "contrib and non-free sources to in sources.list. Please either"
   # echo "fix your /etc/apt/sources.list, fix this script, or comment out"
   # echo "this section to skip it."
 # fi
#fi
# could also be we have no lines in the file to begin with
#if [ "$(echo "$SRCLINE" | wc -l)" -lt 1 ]; then
 # echo "NOTE: either something in /etc/apt/sources.list is very wrong, or"
 # echo "We need to add a deb line for your binary packages. If you want"
 # echo "to add these sources, press enter. Otherwise, abort the script and fix"
 # echo "things."
  #continueok
  #sudo sh -c 'echo "deb http://ftp.us.debian.org/debian sid main contrib non-free" >> /etc/apt/sources.list'
#fi
#if [ -n "$SRCLINE" ]; then
 # SRCLINE_SED="$(echo "$SRCLINE" | sed 's/\[/\\\[/g;s/\]/\\\]/g' )"
 # export RESULT=1
  #set -x
  #sudo sh -c "sed 's/$"
  #set +x
  #grep 'sid main' /etc/apt/sources.list
  #grep -Fxq 'deb http://ftp.us.debian.org/debian sid main contrib non-free' /etc/apt/sources.list
  #if [ "$?" -ne 0 ]; then
    #set -x
    # this should really just append ' contrib non-free' to the end of the
    # line but I'm having some trouble with sed and I'm leaving for school
    # pretty soon. :(
#    sudo sh -c 'echo "deb-src http://ftp.us.debian.org/debian sid main contrib non-free" >> /etc/apt/sources.list'
 #   set +x
  #fi
  #unset RESULT
#fi
# deb-src:
#export RESULT=1
#grep -Fxq 'deb-src http://ftp.us.debian.org/debian sid main contrib non-free' /etc/apt/sources.list
#if [ "$?" -ne 0 ]; then
  #set -x
#  sudo sh -c 'echo "deb-src http://ftp.us.debian.org/debian sid main contrib non-free" >> /etc/apt/sources.list'
 # set +x
#fi
#unset RESULT
#sudo apt-get update
set +x
#echo "Next up:"
#echo "Building fvwm from source with a patch for CJK fallback fonts."
#continueok
#set -x
#sudo apt-get build-dep fvwm
#mkdir -p "$HOME""/development/fvwm"
#cd "$HOME""/development/fvwm"
#apt-get source fvwm
## hoping this is the right dir :\
#cd "$(find . -maxdepth 1 -type d -name "fvwm*" | head -n 1)"
#patch -p0 < "$STARTDIR""/patches/fvwm.cjk.patch"
#echo "if patch was successful, hit enter to build."
#dpkg-buildpackage -uc -us -b
#cd "$HOME""/development/fvwm"
#DEBNAME="$(find . -maxdepth 1 -name "*.deb")"
#sudo dpkg -i "$DEBNAME"
set +x
cd "$STARTDIR"
echo "Next up:"
echo "Installing some multimedia programs, tools, libraries, and development"
echo "headers (basically, everything that my ffmpeg build needs except for"
echo "libdvdcss)."
continueok
set -x
sudo apt-get install libx264-dev libx265-dev libfdk-aac-dev libogg-dev \
     libvorbis-dev libtheora-dev libspeex-dev libvpx-dev libflac-dev flac \
     libopus-dev libass-dev libasound2-dev alsa-oss gimp alsa-utils \
     libgme-dev libmp3lame-dev libxvidcore-dev libgstreamer1.0-dev \
     libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev \
     mpv i965-va-driver libvdpau-va-gl1 libtwolame-dev libwebp-dev zlib1g-dev \
     libdvdnav-dev libdvdread-dev cdparanoia libcdparanoia-dev libcdio-utils \
     cdrdao cue2toc libvo-amrwbenc-dev libopencore-amrwb-dev \
     libopencore-amrnb-dev libgmp-dev libssl-dev libvidstab-dev libcaca-dev \
     libfreetype6-dev libfribidi-dev libfontconfig1-dev libxml2-dev libaom-dev
     
     
set +x
echo "Next up:"
echo "Installing system management tools (gparted)."
continueok
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
cd "$STARTDIR"
set +x

echo "Next up:"
echo "Checking out, compiling, and installing libdvdcss."
continueok
set -x
mkdir -p "$HOME""/development"
cd "$HOME""/development"
if [ ! -d "libdvdcss" ]; then
  git clone 'http://code.videolan.org/videolan/libdvdcss.git'
fi
cd libdvdcss/
git pull
autoreconf -i
./configure --prefix=/usr
make
sudo make install
cd "$STARTDIR"
set +x
echo "Should now be done installing libdvdcss."

echo "Next up:"
echo "Checking out, compiling, and installing ffmpeg. This will take a while."
continueok
# echo '======ffmpeg configuration======:'
# echo '--prefix=/usr --enable-gpl --enable-nonfree --enable-version3 --enable-libx264 --enable-libvpx --enable-libxcb-shm --enable-libxcb --enable-libwebp --enable-libtheora --enable-libvorbis --enable-libx265 --enable-libvorbis --enable-libv4l2 --enable-libtwolame --enable-libspeex --enable-libxcb-shape --enable-libwebp --enable-libvo-amrwbenc --enable-libass --enable-gmp --enable-libmp3lame --enable-libfdk-aac --enable-openssl --enable-libvidstab --enable-libgme --enable-libcaca --enable-libfreetype --enable-libfribidi --enable-libfontconfig --enable-libxml2 --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libaom'

# echo "Reminder: You may want to install a dvdcss library (not in the debian"
# echo "repositories) before trying to do anything like building ffmpeg or"
# echo "mplayer from sources."

set -x
mkdir -p "$HOME""/development"
cd "$HOME""/development"
if [ ! -d "ffmpeg" ]; then
  git clone 'https://git.ffmpeg.org/ffmpeg.git'
fi
cd ffmpeg/
git pull
# ffmpeg configure
./configure --prefix=/usr --enable-gpl --enable-nonfree --enable-version3 --enable-libx264 --enable-libvpx --enable-libxcb-shm --enable-libxcb --enable-libwebp --enable-libtheora --enable-libvorbis --enable-libx265 --enable-libvorbis --enable-libv4l2 --enable-libtwolame --enable-libspeex --enable-libxcb-shape --enable-libwebp --enable-libvo-amrwbenc --enable-libass --enable-gmp --enable-libmp3lame --enable-libfdk-aac --enable-openssl --enable-libvidstab --enable-libgme --enable-libcaca --enable-libfreetype --enable-libfribidi --enable-libfontconfig --enable-libxml2 --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libaom
make
set +x
echo "ffmpeg installation will follow upon confirmation that the compile succeeded."
continueok
set -x
echo "Installing ffmpeg (performing 'make install')."
sudo make install
set +x
echo "If everything ran properly, ffmpeg should now be installed."
echo "Next up:"
echo "Adding fvwm (already installed) as a provider for x-session-manager."
continueok
set -x
# add fvwm2 as an x-session-manager provider
sudo update-alternatives --install update-alternatives --install /usr/bin/x-session-manager x-session-manager /usr/bin/fvwm2 55
set +x
echo "I've just added fvwm2 as an available x-session-manager."
echo "Please select your preferred X session."
set -x
sudo update-alternatives --config x-session-manager
set +x
echo "Next up:"
echo "Adding rule to allow ctrl-alt-backspace to restart the X server."
continueok
# allow ctrl+alt+backspace to restart X server
# (debian specific maybe)
if [ -f /etc/default/keyboard ]; then
  echo "Attempting to add an option to restart the X server with ctrl+alt+backspace"
  echo "to /etc/default/keyboard."
  set -x
  TEMPKEYBOARD="$(mktemp --tmpdir=/tmp keyboarddefaultXXX)"
  sed 's/XKBOPTIONS=""/XKBOPTIONS="terminate:ctrl_alt_bksp"/g' < /etc/default/keyboard > "$TEMPKEYBOARD"
  cat "$TEMPKEYBOARD" > /etc/default/keyboard
  rm "$TEMPKEYBOARD"
  set +x
else
  echo "WARNING: /etc/default/keyboard was not found. You may have to manually"
  echo "configure XKB/X11 to allow ctrl+alt+backspace to restart the server."
fi
echo "Next up:"
echo "Downloading Seamonkey EarlyBlue theme to ~/.mozilla so I have it when I"
echo "need it (this theme matches well with the CDE motif look I'm shooting for)."
continueok
set -x
wget 'https://addons.thunderbird.net/seamonkey/downloads/latest/earlyblue/addon-3050-latest.xpi' \
     -O ~/.mozilla/
set +x
echo "Next up:"
echo "Installing Deluge daemon, Deluge GTK client, Deluge console client, and"
echo "deluge web client."
continueok
set -x
sudo apt-get install deluged deluge-gtk deluge-console deluge-web
set +x
echo "Next up:"
echo "Copying udev rules and hwdb entries to /etc/udev."
continueok
# to do: copy policykit rules and udev rules
# (when not using systemd as an init system, policykit rules are more
# important. I don't remove systemd-as-init with this script because doing so
# is a highly involved, volatile, and irritating process in Debian and I don't
# want to trash my fresh installation by trying to plow ahead with it.)
# (also, systemd-shim appears to be out of date.)

# udev
set -x
cd "$STARTDIR""/etc/udev"
sudo sh -c 'tar -c -f - hwdb.d/ rules.d/ | tar -C /etc/udev -x -v -f - '
sudo chown -R root:root /etc/udev
sudo sh -c 'find /etc/udev/ -type f -print0 | xargs -0 chmod 644'
sudo sh -c 'find /etc/udev/ -type d -print0 | xargs -0 chmod 755'
set +x
cd "$STARTDIR/etc"
echo "Next up:"
echo "Copying policykit rules to /etc/polkit-1 and setting correct permissions."
continueok
# /etc/polkit-1/localauthority dir is only readable/writable by owner (root) on
# my debian system. Files inside it however are globally readable and owner-
# writable.
set -x
cd "$STARTDIR""/etc/polkit-1"
mkdir -p /etc/polkit-1
sudo sh -c 'tar -c -f - rules.d/ localauthority.conf.d/ localauthority/ | tar -C /etc/polkit-1 -x -v -f - '
sudo chown -R root:root /etc/polkit-1
sudo sh -c 'find /etc/polkit-1/ -type f -print0 | xargs -0 chmod 644'
sudo sh -c 'find /etc/polkit-1/ -type d -print0 | xargs -0 chmod 755'
sudo chmod 700 /etc/polkit-1/localauthority
cd "$STARTDIR"
set +x
echo "Next up:"
echo "Copying xorg.conf to /etc/X11/xorg.conf."
continueok
set -x
sudo mkdir -p /etc/X11
sudo cp "$STARTDIR""/etc/X11/xorg.conf" "/etc/X11/xorg.conf"
set +x
echo "done copying."
#echo "Next up:"
#echo "Installing intel-gpu-tools for the intel_backlight utility."
#continueok
## my ACPI scripts (installed next) depend on intel_backlight to actually turn
## the backlight completely _off_. LVDS laptops don't provide the means for
## this via sysfs like eDP ones do (More accurately, the provided sysfs file
## does nothing to the backlight state on LVDS models).
#set -x
#sudo apt-get install intel-gpu-tools
#set +x
echo "Next up:"
echo "Copying ACPI actions/event rules to /etc/acpi."
continueok
set -x
cd "$STARTDIR""/etc/acpi"
sudo sh -c 'tar -c -f - * | tar -C /etc/acpi -x -v -f - '
sudo chown -R root:root /etc/udev
sudo sh -c 'find /etc/acpi/ -type f -print0 | xargs -0 chmod 644'
sudo sh -c 'find /etc/acpi/ -type d -print0 | xargs -0 chmod 755'
cd "$STARTDIR"
set +x
echo "Next up:"
echo "Reloading ACPI rules by killing the acpi daemon (acpid). If your system is set"
echo "to automatically spawn acpid (as it should be), it will restart. Otherwise it"
echo "will need to be manually restarted later."
continueok
set -x
sudo kill -SIGHUP `pidof acpid`
set +x
#echo "Next up:"
#echo "Copying rc.local to /etc/rc.local. This is a startup script that just"
#echo "performs a few actions like setting up my keymap and turning off"
#echo "the bluetooth/WAN radios at boot."
#echo "THIS WILL OVERWRITE AN EXISTING rc.local FILE."
#continueok
#set -x
#sudo sh -c 'cat '"$STARTDIR"'/etc/rc.local > /etc/rc.local'
set +x
echo "Reached end of setup script! Exiting."
