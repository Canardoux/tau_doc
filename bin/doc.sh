#!/bin/bash

rm -rf _site
bundle config set --local path '~/vendor/bundle'
bundle install
bundle exec jekyll build

if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi

cp index.html _site

git add .
git commit -m 'tau-doc update'
git pull
git push

ssh tau@danku "rm -rf /var/www/canardoux.xyz/tau/*"
scp -r _site/* tau@danku:/var/www/canardoux.xyz/tau/ >/dev/null