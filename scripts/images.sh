#!/bin/bash

target_format="avif"

images=$(find . -name '*.png')
for image in $images; do
    echo "$image..."
    magick "$image" -strip "${image%.*}.$target_format"
done
