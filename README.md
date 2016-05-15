# E.A.K. Build & Deploy scripts

These scripts assume a directory structure like this:
```
EAK - project root
├── E.A.K. - https://github.com/drumrollhq/E.A.K. - the main E.A.K. game
├── hindquarters - https://github.com/drumrollhq/eak-hindquarters - api server
├── scripts - This repo
└── web - https://github.com/drumrollhq/eak-web - E.A.K. website
```

You also need the following command line tools installed:

* `serve` - `npm install --global serve`
* `s3cmd` - `brew install s3cmd`

### Building the game and website
As the game is served from the same domain as the website, they are built and deployed as one.
To build the game and website, run:
```sh
./prepare-web-deploy.sh
```

This script:

1. Cleans up any old builds
2. Creates a production build of the game
3. Creates a production build of the website
4. Merges the game and website builds in a `web-deploy` folder
5. Starts a server for the new build and opens your browser for you to check everything is working correctly

If you find errors in the build that don't make sense, you can try clearing the cache that the E.A.K.
build tool uses to speed things up:
```sh
cd ../E.A.K.
gulp clean-all
cd -
```

### Deploying the game and website
To safely (ie without visitors encountering a half-uploaded game) upload the game to S3, use:
```sh
./web-upload.sh $UPLOAD_TARGET
```

where `$UPLOAD_TARGET` is the url to an S3 bucket e.g. `./web-upload.sh s3://tipexsomefelines.net`.

Make sure you have `s3cmd` configured with the correct access credentials for your s3 bucket.
