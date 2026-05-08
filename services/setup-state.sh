#!/bin/bash
for i in {0..2}; do cat - >> $VOLDIR/myapp-$i.conf <<EOF
events {}
http {
  server {
    listen 80;
    location / {
      return 200 "This is myapp-$i\n";
    }
  }
}
EOF
done
