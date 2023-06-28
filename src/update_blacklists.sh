#!/bin/sh -e

. $(dirname "${0}")/censorship_params.sh

${ROOT_DIR}/update_cncpo.sh || true
${ROOT_DIR}/update_aams.sh  || true
${ROOT_DIR}/update_admt.sh  || true
${ROOT_DIR}/update_agcom.sh  || true
${ROOT_DIR}/update_manual.sh  || true

systemctl reload unbound # or `rndc reload` according to your mileage
