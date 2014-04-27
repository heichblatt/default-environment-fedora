#!/usr/bin/env bash

set -e
source ./vars

# install Sublime Text 3 from tarball + install Package Control
# loosely based on http://simonewebdesign.it/blog/install-sublime-text-3-on-fedora-20/

URL=http://www.sublimetext.com/3
TMPDIR=$(mktemp --directory)
TARBALL="$TMPDIR"/st3.tar.bz2
PACKAGECONTROL_URL=https://sublime.wbond.net/Package%20Control.sublime-package

echo Installing Sublime Text 3.
which lynx > /dev/null 2>&1 || "$INSTALL" lynx
URL_TARBALL=$(lynx -dump -listonly "$URL" \
  | grep "x64.tar.bz2" \
  | awk '{ print $NF }' )

curl --progress-bar -o "$TARBALL" "$URL_TARBALL"
if tar -xf "$TARBALL" --directory="$TMPDIR"; then
  $SUDO mv "$TMPDIR"/sublime_text_3/ /opt/
  $SUDO ln -s /opt/sublime_text_3/sublime_text /bin/subl
fi
rm -r "$TMPDIR"

$SUDO bash -c "cat << EOF > /usr/share/applications/sublime.desktop
[Desktop Entry]
Name=Sublime Text
Exec=subl %F
MimeType=text/plain;
Terminal=false
Type=Application
Icon=/opt/sublime_text_3/Icon/128x128/sublime-text.png
Categories=Utility;TextEditor;Development;
EOF"

echo Installing Package Control.
curl --progress-bar "$PACKAGECONTROL_URL" > /opt/sublime_text_3/Packages/"Package Control.sublime-package" 
trap "rm -rf $TMPDIR; exit" 2
