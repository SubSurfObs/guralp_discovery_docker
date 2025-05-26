FROM --platform=linux/amd64 rockylinux:9

# Install all required dependencies at once

RUN dnf install -y \
    bash curl wget tar unzip \
    mesa-libGL libxkbcommon pulseaudio-libs nss libXcomposite \
    libXdamage libXrender libXrandr libXtst alsa-lib libxkbfile \
    libwayland-client libwayland-server \
    qt5-qtbase qt5-qtbase-gui qt5-qtbase-devel qt5-qtx11extras \
    dbus dbus-daemon dbus-tools \
    --allowerasing && dnf clean all

# Generate machine-id for dbus to avoid startup error
RUN dbus-uuidgen > /etc/machine-id

# Set working directory
WORKDIR /opt/discovery

# Copy installer into image and make executable
COPY discovery_v2_1_2108_rocky.sh ./discovery.sh
RUN chmod +x discovery.sh

CMD ["./discovery.sh"]


