#!/bin/sh -e

. $(dirname "${0}")/parameters.sh

if [ ! -d "${TMP_DL_DIR}" ]
then
   echo "Missing temp download dir ${TMP_DL_DIR}"
   mkdir "${TMP_DL_DIR}"
fi

. ${ROOT_DIR}/update_cncpo.sh || true
. ${ROOT_DIR}/update_aams.sh  || true
. ${ROOT_DIR}/update_admt.sh  || true
. ${ROOT_DIR}/update_agcom.sh  || true
. ${ROOT_DIR}/update_manual.sh  || true

if [ $OUTPUT_FORMAT = "unbound" ]; then
    systemctl reload unbound
elif [ $OUTPUT_FORMAT = "bind" ]; then
    systemctl reload bind
fi

# or `rndc reload` according to your mileage
