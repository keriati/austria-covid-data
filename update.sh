#!/bin/bash

readonly DATA_URL="https://info.gesundheitsministerium.at/data/data.zip"
readonly DATA_ARCHIVE_NAME="data.zip"
readonly DATE_STAMP="$(date +"%F-%H%M%S")"
readonly DATA_PATH="data/data-$DATE_STAMP"
readonly COMMIT_MESSAGE="Add data $DATE_STAMP"

echo "Downloading archive..."
curl $DATA_URL --output $DATA_ARCHIVE_NAME --silent

if test -f "$DATA_ARCHIVE_NAME"; then
    echo "Download successful."
    unzip -qq $DATA_ARCHIVE_NAME -d $DATA_PATH
    rm $DATA_ARCHIVE_NAME
    git add --all >/dev/null
    git commit -am "$COMMIT_MESSAGE" --quiet
    git push origin master --quiet
    echo "Data pushed to origin"
else
    echo "Download failed."
fi

