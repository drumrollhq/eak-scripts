#!/bin/bash

set -eux

cd ../web-deploy

# First, upload the versioned packages
s3cmd sync --rexclude '^(?!.*eakpackage).*$' ./ $1
# Next, the bundle file
s3cmd sync --rexclude '^(?!.*bundles.*json).*$' ./ $1
# Then, everything else
s3cmd sync ./ $1
