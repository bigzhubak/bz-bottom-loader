#! /bin/bash
sh ./change_name.sh
npm run build
git commit -am "update name"
npm version patch
npm publish ./
