#!/bin/bash
set -e

rm -rf $HOME/flutter
rm -rf /vercel/path0/flutter

curl -o /tmp/flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.29.2-stable.tar.xz
tar xf /tmp/flutter.tar.xz -C $HOME

export PATH="$HOME/flutter/bin:$PATH"

git config --global --add safe.directory $HOME/flutter

dart pub cache clean -f

flutter pub get
flutter build web --release