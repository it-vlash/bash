#!/bin/bash

set -e

UPLOADS_ROOT_PATH="backend/web/uploads";
BACKUPS_SOURCE="backups/";

echo "#########################################";
echo "#--Selected backup date:-$1-----#";
echo "#########################################";

if [[ $1 != [0-9][0-9]-[0-9][0-9]-[2][0][1-2][0-9] ]]
  then
    echo 'Your date is wrong.';
    exit;
fi

if [[ -f "$BACKUPS_SOURCE"$1"/uploads.zip" ]] && [[ -f "$BACKUPS_SOURCE"$1"/dump.sql.gz" ]]
  then

    if [[ ! -d $UPLOADS_ROOT_PATH ]];
      then
        echo "Creating backend directory...";
        mkdir -p "$UPLOADS_ROOT_PATH";
    fi

    if [[ -f $BACKUPS_SOURCE"$1/uploads.zip" ]];
      then
        unzip -K $BACKUPS_SOURCE"$1/uploads.zip" -d $UPLOADS_ROOT_PATH/;
        echo 'UPLOADS backup unzipped!';
    fi

    if [[ -f $BACKUPS_SOURCE"$1/dump.sql.gz" ]];
      then
        gzip -k -d $BACKUPS_SOURCE"$1/dump.sql.gz";
        mv $BACKUPS_SOURCE"$1/dump.sql" ./dump.sql;
        echo 'SQL backup unzipped!';
    fi

  else
    echo 'Backup file not found.';
  exit;
fi

echo '#########################################';
echo '********* RESTORING COMPLETE! ***********';
