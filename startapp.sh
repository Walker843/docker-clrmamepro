#!/bin/sh
# startapp.sh - Launches CLRMamePro under Wine

export WINEPREFIX=/config/wine
export WINEDEBUG=-all

# Fix ownership of CLRMamePro directories to match the app user
chown -R app:app /opt/clrmamepro/

# Initialize Wine prefix on first run
if [ ! -d "$WINEPREFIX" ]; then
    echo "Initializing Wine prefix..."
    wineboot --init
fi

# Launch CLRMamePro
exec wine /opt/clrmamepro/cmpro64.exe
