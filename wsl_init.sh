#!/usr/bin/env bash

echo 'export DOCKER_HOST=tcp://localhost:2375' >> ~/.bashrc

cat <<EOF | sudo tee /etc/wsl.conf
[interop]
appendWindowsPath = false #not use windows %Path%
[automount]
root = /  #change drive mount from /mnt/c/ -> /c/
EOF
