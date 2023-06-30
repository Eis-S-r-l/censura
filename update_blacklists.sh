#!/bin/sh

. $(dirname "${0}")/parameters.sh

if [ ! -d "${TMP_DL_DIR}" ]
then
   echo "Missing temp download dir ${TMP_DL_DIR}"
   mkdir "${TMP_DL_DIR}"
fi

ErrorMailHead="<!DOCTYPE html><html lang=\"en\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><meta name=\"viewport\" content=\"width=device-width\"><title></title><style></style></head><body><table style=\"width:100%\"><tr><th>List Name</th><th>Downloaded</th><th>Updated</th></tr>"

ErrorMailSend=false

. ${ROOT_DIR}/update_cncpo.sh || true
. ${ROOT_DIR}/update_aams.sh || true
. ${ROOT_DIR}/update_admt.sh || true
. ${ROOT_DIR}/update_agcom.sh || true
. ${ROOT_DIR}/update_manual.sh || true

ErrorMailFooter="</table></body></html>"

ErrorMailBody="$ErrorMailHead $ErrorMailCncpo $ErrorMailAams $ErrorMailAdmt $ErrorMailAgcom $ErrorMailManual $ErrorMailFooter"

if [ $MAIL_ALERTS_ENABLED = true ] && [ $ErrorMailSend = true ]; then
    if [ $MSMTP_BIN ]; then
        hs=`hostname`
        MSMTP_OPTS="-a ${MAIL_MSMTP_ACCOUNT} ${MAIL_ALERTS_TO}"

        MAIL="Content-type: text/html\nSubject: Blacklists update FAILED on ${hs}\n\n $ErrorMailBody"

        echo $MAIL | ${MSMTP_BIN} ${MSMTP_OPTS}
    else
        echo "msmtp not installed, skipping e-mail alert"
    fi
fi

dnsReloaded=true

if [ $OUTPUT_FORMAT = "unbound" ]; then
    systemctl reload unbound
    if [ $? -ne 0 ];then
        echo "Couldn't reload Unbound"
        dnsReloaded=false
    fi

elif [ $OUTPUT_FORMAT = "bind" ]; then
    systemctl reload bind
    if [ $? -ne 0 ];then
        echo "Couldn't reload Bind"
        dnsReloaded=false
    fi
fi


# or `rndc reload` according to your mileage
