#!/bin/bash
THIS_DIR=$(cd "$(dirname "$BASH_SOURCE")"; pwd)
convert -crop 15x15@ $THIS_DIR/image.jpg  $THIS_DIR/../tiles/tile_%d.jpg
