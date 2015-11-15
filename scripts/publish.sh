#!/bin/bash
export LC_ALL=en_US.UTF-8
THIS_DIR=$(cd "$(dirname "$BASH_SOURCE")"; pwd)
cd $THIS_DIR/../
rsync -avc index.html favicon.png style.css http2_logo.svg tiles $1

