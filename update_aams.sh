#!/bin/sh -e
LIST_FILE="${TMP_DL_DIR}/blacklist_aams.txt"
LIST_OUT="${UNBOUND_CONF_DIR}/db.blacklist_aams.conf"
LIST_TYPE="aams"

WGET_CERTS=""
WGET_OPTS="${WGET_CERTS} --no-check-certificate"
PARSER_OPTS="-i ${LIST_FILE} -o ${LIST_OUT} -f ${OUTPUT_FORMAT} -d ${LIST_TYPE} -b ${BLACKHOLE_AAMS}"

## downloading ###############################################################
python3 $(dirname "${0}")/download_aams.py -o ${LIST_FILE}

if [ $? -ne 0 ];then
  echo "Couldn't download latest AAMS list"
  ErrorMailAams="<tr><td><center>AAMS</center></td><td><center>failed</center></td><td><center>N/A</center></td></tr>"
  ErrorMailSend=true
else
## parsing ###################################################################
  ${PARSER_BIN} ${PARSER_OPTS}
  if [ $? -ne 0 ];then
    echo "Couldn't parse latest AAMS list"
    ErrorMailAams="<tr><td><center>AAMS</center></td><td><center>success</center></td><td><center>failed</center></td></tr>"
    ErrorMailSend=true
  fi
fi
