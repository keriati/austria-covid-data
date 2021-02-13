#!/bin/bash

readonly DATA_URL_AGES="https://covid19-dashboard.ages.at/data/data.zip"
readonly DATA_URL="https://info.gesundheitsministerium.at/data/data.zip"
readonly VAC_LAENDER_URL="https://info.gesundheitsministerium.at/data/laender.csv"
readonly VAC_NATIONAL_URL="https://info.gesundheitsministerium.at/data/national.csv"
readonly VAC_TIMELINE_URL="https://info.gesundheitsministerium.at/data/timeline.csv"
readonly VAC_TIMELINE_BBG_URL="https://info.gesundheitsministerium.at/data/timeline-bbg.csv"
readonly VAC_TIMELINE_PASS_URL="https://info.gesundheitsministerium.at/data/timeline-eimpfpass.csv"
readonly VAC_TIMELINE_BLM_URL="https://info.gesundheitsministerium.at/data/timeline-bundeslaendermeldungen.csv"
readonly DATA_ARCHIVE_NAME_AGES="data-ages.zip"
readonly DATA_ARCHIVE_NAME="data.zip"
readonly DATE_STAMP="$(date +"%F-%H%M%S")"
readonly DATA_PATH_AGES="data/data-ages-$DATE_STAMP"
readonly DATA_PATH="data/data-$DATE_STAMP"
readonly VAC_PATH="data/data-vac-$DATE_STAMP"
readonly COMMIT_MESSAGE="Sync $DATE_STAMP"

curl $DATA_URL_AGES --output $DATA_ARCHIVE_NAME_AGES --silent
curl $DATA_URL --output $DATA_ARCHIVE_NAME --silent
curl $VAC_LAENDER_URL --create-dirs --output "$VAC_PATH/laender.csv"
curl $VAC_NATIONAL_URL --create-dirs --output "$VAC_PATH/national.csv"
curl $VAC_TIMELINE_URL --create-dirs --output "$VAC_PATH/timeline.csv"
curl $VAC_TIMELINE_BBG_URL --create-dirs --output "$VAC_PATH/timeline-bbg.csv"
curl $VAC_TIMELINE_PASS_URL --create-dirs --output "$VAC_PATH/timeline-eimpfpass.csv"
curl $VAC_TIMELINE_BLM_URL --create-dirs --output "$VAC_PATH/timeline-bundeslaendermeldungen.csv"

if test -f "$DATA_ARCHIVE_NAME"; then
    unzip -qq $DATA_ARCHIVE_NAME_AGES -d $DATA_PATH_AGES
    unzip -qq $DATA_ARCHIVE_NAME -d $DATA_PATH
    rm $DATA_ARCHIVE_NAME_AGES
    rm $DATA_ARCHIVE_NAME
    git add --all >/dev/null
    git commit -am "$COMMIT_MESSAGE" --quiet
    git push origin master --quiet
fi
