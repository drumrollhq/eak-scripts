#!/bin/sh
set -eux

cd ..

rm -rf web-deploy
mkdir web-deploy

cd E.A.K.
gulp update-api --production
# gulp clean-all
gulp build --production

cd ../web
gulp optimize

cd ../web-deploy
cp -r ../E.A.K./public/* ./
cp -r ../web/public/* ./

serve -p 8888 & (sleep 1 && open 'http://localhost:8888') & wait
