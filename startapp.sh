#!/bin/sh
# startapp.sh - Launches CLRMamePro under Wine

export WINEPREFIX=/config/wine
export WINEDEBUG=-all

# Initialize Wine prefix on first run
if [ ! -d "$WINEPREFIX" ]; then
    echo "Initializing Wine prefix..."
    wineboot --init
fi

# Launch CLRMamePro
exec wine /opt/clrmamepro/cmpro64.exe
