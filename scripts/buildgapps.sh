#!/bin/bash
# gapps build script

rm -rf /var/www/html/Gapps/Kitkat/* && rm -rf /var/www/html/Gapps/Lollipop/5.0/* && rm -rf /var/www/html/Gapps/Lollipop/5.1/*
ssh root@104.236.22.120 rm -rf "/var/www/html/gapps/kitkat/*"
ssh root@104.236.22.120 rm -rf "/var/www/html/gapps/lollipop/*"
cd ~/slimlp_gapps
git checkout master
ant
~/buildchecksums.sh ./build
mv ./build/Slim* /var/www/html/Gapps/Lollipop/5.0
git checkout lp5.1
ant
~/buildchecksums.sh ./build
mv ./build/Slim* /var/www/html/Gapps/Lollipop/5.1
rsync -r -v --progress /var/www/html/Gapps/Lollipop/* root@104.236.22.120:/var/www/html/gapps/lollipop
cd ~/slimkat_gapps
ant
~/buildchecksums.sh ./build
mv ./build/Slim* /var/www/html/Gapps/Kitkat
rsync -r -v --progress /var/www/html/Gapps/Kitkat/* root@104.236.22.120:/var/www/html/gapps/kitkat
