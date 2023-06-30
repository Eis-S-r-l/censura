#!/bin/sh -e

LIST_URL="https://www1.adm.gov.it/files_siti_inibiti_tabacchi/elenco_siti_inibiti.txt"
LIST_FILE="${TMP_DL_DIR}/blacklist_admt.txt"
LIST_OUT="${UNBOUND_CONF_DIR}/db.blacklist_admt.conf"
LIST_TYPE="admt"

WGET_CERTS=""
WGET_OPTS="${WGET_CERTS} --no-check-certificate"
PARSER_OPTS="-i ${LIST_FILE} -o ${LIST_OUT} -f ${OUTPUT_FORMAT} -d ${LIST_TYPE} -b ${BLACKHOLE_ADMT}"

##############################################################################
# be verbose when stdout is a tty
if [ ! -t 0 ]; then
  WGET_OPTS="$WGET_OPTS -q"
fi

## downloading ###############################################################
${WGET_BIN} ${WGET_OPTS} ${LIST_URL} -O ${LIST_FILE}

if [ $? -ne 0 ];then
  echo "Couldn't download latest ADMT list"
  ErrorMailAdmt="<tr><td><center>ADMT</center></td><td><center>failed</center></td><td><center>N/A</center></td></tr>"
  ErrorMailSend=true
else
## parsing ###################################################################
  ${PARSER_BIN} ${PARSER_OPTS}
  if [ $? -ne 0 ];then
    echo "Couldn't parse latest ADMT list"
    ErrorMailAdmt="<tr><td><center>ADMT</center></td><td><center>success</center></td><td><center>failed</center></td></tr>"
    ErrorMailSend=true
  fi
fi
