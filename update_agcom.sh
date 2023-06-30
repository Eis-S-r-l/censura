#!/bin/sh

LIST_FILE="${TMP_DL_DIR}/blacklist_agcom.txt"
LIST_OUT="${UNBOUND_CONF_DIR}/db.blacklist_agcom.conf"
LIST_TYPE="agcom"
PARSER_OPTS="-i ${LIST_FILE} -o ${LIST_OUT} -f ${OUTPUT_FORMAT} -d ${LIST_TYPE} -b ${BLACKHOLE_AGCOM}"

## downloading ###############################################################
python3 $(dirname "${0}")/download_agcom.py -o ${LIST_FILE}

if [ $? -ne 0 ];then
    echo "Couldn't download latest AGCOM list"
    ErrorMailAgcom="<tr><td><center>AGCOM</center></td><td><center>failed</center></td><td><center>N/A</center></td></tr>"
    ErrorMailSend=true
else
## parsing ###################################################################
    ${PARSER_BIN} ${PARSER_OPTS}
    if [ $? -ne 0 ];then
        echo "Couldn't parse latest AGCOM list"
        ErrorMailAgcom="<tr><td><center>AGCOM</center></td><td><center>success</center></td><td><center>failed/td></tr>"
        ErrorMailSend=true
    fi
fi
