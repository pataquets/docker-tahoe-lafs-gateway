FROM pataquets/tahoe-lafs-node

ADD sftp.cfg /tmp/

RUN \
  sed -i \
    -e 's/nickname = /nickname = tahoe-lafs-gateway/' \
    -e 's/^tub.port = /#tub.port = /' \
    -e 's/^#shares.needed = 3$/shares.needed = 1/' \
    -e 's/^#shares.happy = 7$/shares.happy = 1/' \
    -e 's/^#shares.total = 10$/shares.total = 1/' \
    -e '/^\[storage\]$/{n;n;s/enabled = true/enabled = false/}' \
    .tahoe/tahoe.cfg \
  && \
  cat /tmp/sftp.cfg >> .tahoe/tahoe.cfg && \
  rm /tmp/sftp.cfg \
  && \
  nl .tahoe/tahoe.cfg \
  && \
  grep -Pzo "\[storage\]\n.*\nenabled = false$" .tahoe/tahoe.cfg && \
  grep "^#tub.port = " .tahoe/tahoe.cfg && \
  grep "^shares.needed = 1$" .tahoe/tahoe.cfg && \
  grep "^shares.happy = 1$" .tahoe/tahoe.cfg && \
  grep "^shares.total = 1$" .tahoe/tahoe.cfg \
  && \
  touch .tahoe/private/accounts && \
  ssh-keygen -N '' -C "root@tahoe-lafs INSECURE KEY" -b 4096 -f .tahoe/private/ssh_host_rsa_key
