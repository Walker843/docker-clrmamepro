# Modernized CLRMamePro Docker container
# Based on jlesage/baseimage-gui v4 (Ubuntu 24.04)
# Wine is used to run the Windows binary on Linux

FROM jlesage/baseimage-gui:ubuntu-24.04-v4

# Enable 32-bit architecture support and install Wine + dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        p7zip-full \
        unzip \
        wine \
        wine32 \
        wine64 \
        zip \
    && \
    # Find and install the latest CLRMamePro binary
    CMP_LATEST_BINARY=$( \
        curl -fsSL https://mamedev.emulab.it/clrmamepro/ | \
        sed -n 's/.*href="\([^"]*binaries\/cmp[^"]*_64\.zip\)".*/\1/p' | \
        head -1 \
    ) && \
    echo "Installing CLRMamePro: $CMP_LATEST_BINARY" && \
    # Document version
    echo "$(basename --suffix=.zip "$CMP_LATEST_BINARY" | cut -d '_' -f 1)" > /VERSIONS && \
    cat /VERSIONS && \
    # Install CLRMamePro
    mkdir -p /opt/clrmamepro && \
    curl -fsSL -o /tmp/cmp.zip "https://mamedev.emulab.it/clrmamepro/$CMP_LATEST_BINARY" && \
    unzip /tmp/cmp.zip -d /opt/clrmamepro/ && \
    # Allow window decorations if openbox config exists
    { [ -f /etc/xdg/openbox/rc.xml ] && sed -i '/<decor>no<\/decor>/d' /etc/xdg/openbox/rc.xml || true; } && \
    # Set correct ownership and permissions
    chown -R 1000:1000 /opt/clrmamepro && \
    chmod -R 755 /opt/clrmamepro && \
    # Clean up
    apt-get remove -y ca-certificates curl && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Copy startup script and app config
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

# Set application name (v4 baseimage API)
RUN set-cont-env APP_NAME "CLRMamePro"

# Optional: set a default window size
RUN set-cont-env DISPLAY_WIDTH 1280
RUN set-cont-env DISPLAY_HEIGHT 768
