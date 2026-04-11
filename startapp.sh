#!/bin/sh
export WINEPREFIX=/config/wine
export WINEDEBUG=-all

# Fix ownership of CLRMamePro app files only
chown app:app /opt/clrmamepro/*.exe
chown app:app /opt/clrmamepro/*.dll
chown app:app /opt/clrmamepro/*.ini
chown app:app /opt/clrmamepro/*.cfg
chown app:app /opt/clrmamepro/*.xml
chown app:app /opt/clrmamepro/*.txt

# Initialize Wine prefix on first run
if [ ! -d "$WINEPREFIX" ]; then
    echo "Initializing Wine prefix..."
    wineboot --init
fi

exec wine /opt/clrmamepro/cmpro64.exe
