#!/bin/sh
# startapp.sh - Launches CLRMamePro under Wine
# This script is called by the jlesage baseimage-gui startup system

# Initialize Wine prefix on first run
if [ ! -d "$HOME/.wine" ]; then
    echo "Initializing Wine prefix..."
    wineboot --init
fi

# Launch CLRMamePro
exec wine /opt/clrmamepro/cmpro64.exe
