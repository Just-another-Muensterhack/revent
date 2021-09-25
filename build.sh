#!/bin/sh

# build script for cloudflare pages

curl -qo- https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.2.3-stable.tar.xz | tar xJ
#./flutter/bin/flutter upgrade
#./flutter/bin/flutter pub get
./flutter/bin/flutter build web
