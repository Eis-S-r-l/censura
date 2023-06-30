#!/bin/sh -e
# Tune the following parameters according to your environment

ROOT_DIR="/root/censura"
TMP_DL_DIR="${ROOT_DIR}/tmp"
PARSER_BIN="${ROOT_DIR}/censor_parser.py"
WGET_BIN=$(which wget)

CNCPO_LIST_URL='https://212.14.145.50/' #Replace with the correct IP address for CNCPO
CNCPO_CERT_FILE="${ROOT_DIR}/cncpo.pem" #Replace with the CNCPO certificate

MANUAL_LIST_FILE="${ROOT_DIR}/blacklist_manual.txt"

BLACKHOLE_AGCOM="127.0.0.1" #Replace with the chosen IP address for the AGCOM list
BLACKHOLE_CNCPO="127.0.0.1" #Replace with the chosen IP address for the CNCPO list
BLACKHOLE_AAMS="217.175.53.72" #Replace, if changed, with the chosen IP address for the AAMS list
BLACKHOLE_ADMT="217.175.53.228" #Replace, if changed, with the chosen IP address for the ADMT list
BLACKHOLE_MANUAL="127.0.0.1" #Replace with the chosen IP address for the Manual list

MSMTP_BIN=$(which msmtp)
MAIL_ALERTS_ENABLED=false #turn e-mail notifications on failures on or off
MAIL_MSMTP_ACCOUNT="gmail" #specify msmtp account name to be used
MAIL_ALERTS_TO="example@email.com"

OUTPUT_FORMAT="unbound"  # Replace to "bind" or to "unbound"

# Unbound configuration folder
UNBOUND_CONF_DIR="/etc/unbound/blacklists.d"

# Bind configuration folder
BIND_CONF_DIR="/etc/bind/zones/blacklists.d"
