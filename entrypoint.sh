#!/bin/sh

if [[ ${DB_HOST} == "" ]]; then
	echo "Missing DB_HOST env variable"
	exit 1
fi
if [[ ${DB_USER} == "" ]]; then
	echo "Missing DB_USER env variable"
	exit 1
fi
if [[ ${DB_PASS} == "" ]]; then
	echo "Missing DB_PASS env variable"
	exit 1
fi

if [[ ${FTP_HOST} == "" ]]; then
	echo "Missing FTP_HOST env variable"
	exit 1
fi
if [[ ${FTP_USER} == "" ]]; then
	echo "Missing FTP_USER env variable"
	exit 1
fi
if [[ ${FTP_PASS} == "" ]]; then
	echo "Missing FTP_PASS env variable"
	exit 1
fi

# set config.php/maintenance to true
sed -i "s/'maintenance' => false,/'maintenance' => true,/" config/config.php

mysqldump -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" --databases nextcloud mysql > nextcloudDB.dump

# rsync nextcloud folders (at least config/, data/, theme/)
rclone sync . :ftp,host="$FTP_HOST",user="$FTP_USER",pass=$(rclone obscure "$FTP_PASS"):nextcloud/ \
--ignore-errors --exclude=custom_apps/ --exclude=root/ --exclude=tmp/ --exclude=".*"

# set config.php/maintenance to false
sed -i "s/'maintenance' => true,/'maintenance' => false,/" config/config.php
