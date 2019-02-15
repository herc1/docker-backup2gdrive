#!/bin/bash
cd "${0%/*}"

DATE=$(date +%Y%m%d)

function bkp {
 unset NAME
 unset SRC_DIR
 DB_HOST=''
 DB_NAME=''
 DB_USER=''
 DB_PASS=''
 unset MAIL_TO

 source $1
 BACKUP_DIR="${NAME}_${DATE}"
 mkdir $BACKUP_DIR
 for src in ${SRC_DIR[@]}; do
  cp -rf $src $BACKUP_DIR
 done
 if [ ! -z ${DB_HOST} ] || [ ! -z ${DB_NAME} ] || [ ! -z ${DB_USER} ]|| [ ! -z ${DB_PASS} ]; then
  mysqldump -u ${DB_USER} -p${DB_PASS} -h ${DB_HOST} ${DB_NAME} > "${BACKUP_DIR}/${DB_NAME}.sql" 2> /dev/null
 fi
 tar --warning=no-file-changed -zcf "${BACKUP_DIR}.tar.gz" ${BACKUP_DIR}
 rm -rf $BACKUP_DIR
 mpack -s "Backup ${DATE} - ${NAME}" "${BACKUP_DIR}.tar.gz" "${MAIL_TO}"
 rm -rf "${BACKUP_DIR}.tar.gz"
}

for backup in $(ls conf/); do
 bkp conf/$backup
done