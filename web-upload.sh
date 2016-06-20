#!/bin/bash

set -eux

cd ../web-deploy

# First, upload the versioned packages
s3cmd sync --rexclude '^(?!.*eakpackage).*$' ./ $1
# Next, the bundle file
s3cmd sync --rexclude '^(?!.*bundles.*json).*$' ./ $1
# Then, everything else
s3cmd sync ./ $1

# Headers: no-cache on HTML
s3cmd modify \
  --recursive \
  --rexclude '^(?!.*\.html).*$' \
  --add-header='Cache-Control: no-cache' \
  $1

# long cache timeout on eakpackage, kitten gifs, static assets
s3cmd modify \
  --recursive \
  --rexclude '^(?!.*\.(static|gif|eakpackage)).*$' \
  --add-header='Cache-Control: public, max-age=31536000' \
  $1
