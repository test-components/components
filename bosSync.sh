#!/usr/bin/env bash

ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

repos=$1
version=$2

echo "Sleep for 5 seconds"
sleep 5s

mkdir -p $ROOT/temp
remote="https://codeload.github.com/test-components/${repos}/tar.gz/${version}"
filename="temp/${repos}_${version}.tar.gz"
echo "Downloading ${remote}"
echo "curl -o ${ROOT}/${filename} $remote"
curl -o ${ROOT}/${filename} $remote
if [ "$?" != "0" ]; then
    exit 1
fi

info="https://raw.githubusercontent.com/test-components/${repos}/${version}/component.json"
infofile="temp/${repos}_${version}.json"
echo "Downloading ${info}"
echo "curl -o ${ROOT}/${infofile} $info"
curl -o ${ROOT}/${infofile} $info
if [ "$?" != "0" ]; then
    exit 1
fi
echo "cat ${ROOT}/${infofile}"
cat ${ROOT}/${infofile}

ak="${BOS_AK}"
sk="${BOS_SK}"

versions=$(git ls-remote --tags --refs --heads https://github.com/test-components/${repos}.git  | awk -F/ '{print $3}')
versionsfile="temp/${repos}_versions.txt"
echo $versions > ${ROOT}/${versionsfile}
cat ${ROOT}/${versionsfile}

#php -v
php $ROOT/bos/sync.php "${ak}" "${sk}" $repos $version $filename $infofile $versionsfile

if [ "$?" != "0" ]; then
    exit 1
fi
