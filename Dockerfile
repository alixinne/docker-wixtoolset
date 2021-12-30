FROM docker.io/library/fedora:35

RUN dnf install -y wine winetricks wget \
    && dnf clean all \
    && rm -rf /var/cache/yum

ENV WINEARCH=win32 WINEDEBUG=-all WINEPREFIX=/wine

RUN wget -q -O/tmp/wix-binaries.zip https://github.com/wixtoolset/wix3/releases/download/wix3112rtm/wix311-binaries.zip \
    && mkdir -p /opt/wixtoolset \
    && cd /opt/wixtoolset \
    && unzip /tmp/wix-binaries.zip \
    && rm /tmp/wix-binaries.zip \
    && for BINARY in /opt/wixtoolset/*.exe; do \
           NAME=/usr/local/bin/$(basename $BINARY .exe); \
           echo -e "#!/bin/sh\n exec wine $BINARY \"\$@\"" >$NAME; \
           chmod +x $NAME; \
       done

RUN echo -e "#!/bin/sh\n P=\$(pgrep wineserver)\n test -z "\$"P || tail --pid=\$P -f /dev/null" >/usr/local/bin/waitwine \
    && chmod +x /usr/local/bin/waitwine \
    && wine wineboot --init \
    && waitwine

WORKDIR /src
