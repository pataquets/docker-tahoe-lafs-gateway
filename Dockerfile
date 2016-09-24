FROM pataquets/tahoe-lafs-node

RUN \
  sed -i \
    -e 's/nickname = /nickname = tahoe-lafs-gateway/' \
    -e 's/#shares.needed = 3/shares.needed = 1/' \
    -e 's/#shares.happy = 7/shares.happy = 1/' \
    -e 's/#shares.total = 10/shares.total = 1/' \
    -e '/\[storage\]/{n;n;s/enabled = true/enabled = false/}' \
    .tahoe/tahoe.cfg \
  && \
  nl .tahoe/tahoe.cfg \
  && \
  grep -Pzo "\[storage\]\n.*\nenabled = false$" .tahoe/tahoe.cfg && \
  grep "shares.needed = 1" .tahoe/tahoe.cfg && \
  grep "shares.happy = 1" .tahoe/tahoe.cfg && \
  grep "shares.total = 1" .tahoe/tahoe.cfg
