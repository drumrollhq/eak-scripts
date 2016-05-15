#!/bin/zsh
set -eux

cd ..

cd hindquarters
VERSION=`git describe --always --tag --abbrev=0`
HASH=`git rev-parse HEAD`
TIMESTAMP=`date +"%s"`
cd -

if [ -f ./hindquarters-deploy/hindquarters-${VERSION}.zip ]; then
  echo "Deploy zip for ${VERSION} already exists!"
  exit 1
fi

rm -rf .hqd
cp -r hindquarters .hqd

cd .hqd

echo "module.exports = {tag: '${VERSION}', hash: '${HASH}', packaged: ${TIMESTAMP}};" > version-info.js

npm shrinkwrap
rm -rf node_modules
rm -rf .git
rm app/**/*.marko.js

zip -r "hindquarters-${VERSION}.zip" ./
cd -

mkdir -p ./hindquarters-deploy/
mv ".hqd/hindquarters-${VERSION}.zip" ./hindquarters-deploy
rm -rf .hqd
