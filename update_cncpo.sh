#!/bin/sh -e

LIST_FILE="${TMP_DL_DIR}/blacklist_cncpo.csv"
LIST_OUT="${UNBOUND_CONF_DIR}/db.blacklist_cncpo.conf"
LIST_TYPE="cncpo"

WGET_CERTS="--certificate=${CNCPO_CERT_FILE}"
WGET_OPTS="${WGET_CERTS} --no-check-certificate"
PARSER_OPTS="-i ${LIST_FILE} -o ${LIST_OUT} -f ${OUTPUT_FORMAT} -d ${LIST_TYPE} -b ${BLACKHOLE_CNCPO}"

##############################################################################
# be verbose when stdout is a tty
if [ ! -t 0 ]; then
  WGET_OPTS="$WGET_OPTS -q"
fi

## downloading ###############################################################
${WGET_BIN} ${WGET_OPTS} ${CNCPO_LIST_URL} -O ${LIST_FILE}

## parsing ###################################################################
${PARSER_BIN} ${PARSER_OPTS}