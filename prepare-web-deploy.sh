#!/bin/sh
set -eux

cd ..

rm -rf web-deploy
mkdir web-deploy

cd E.A.K.
node_modules/.bin/gulp update-api --production
# node_modules/.bin/gulp clean-all
node_modules/.bin/gulp build --production

cd ../web
node_modules/.bin/gulp optimize

cd ../web-deploy
cp -r ../E.A.K./public/* ./
cp -r ../web/public/* ./

serve -p 8888 & (sleep 1 && open 'http://localhost:8888') & wait
