#!/usr/bin/env bash
# Create user files for both mirakel and taskrc
#
# This script makes 2 assumptions:
# 1. That it's being run as the TASKD user and the TASKD users home is where TASKDDATA is
# 2. That user certificates are stored in TASKDDATA/user_certs/
# 3. That the CA cert is at /etc/pki/taskd/ca.cert.pem
set -eu -o pipefail

# Require an argument
if [ "$#" -lt 1 ]; then
	echo "Hey! I need some input"
	echo "Usage $0 user tasddata pkidir"
	exit 0
else
	readonly U_NAME=$1
	readonly T_DATA=${2:-/var/lib/taskd/}
	readonly T_PKI=${3:-/etc/pki/taskd/}
	readonly T_EXE=`which taskd`
	readonly T_CONFIG="${T_EXE} config --data ${T_DATA}"
	readonly U_NAME_B=${U_NAME/ /_}
fi

# Verify T_DATA Directory
if [ ! -d "${T_DATA}" ]; then
	echo "TASKDDATA Directory Does Not Exist"
	exit 1
fi

# Verify U_NAME exists
U_INFO=`grep -rwl "${U_NAME}"`
rc=$?

if [ $rc != 0 ]; then
	echo "No Such User"
	exit 1
fi

# Verify ca.cert Is Set
CA_CERT=`${T_CONFIG} | grep "ca.cert"`
rc=$?

if [ $rc != 0 ]; then
	echo "ca.cert Is Not set"
	exit 1
fi

CA_CERT=`echo ${CA_CERT} | awk '{print $2}'`
if [ ! -e "${CA_CERT}" ]; then
	echo "ca.cert Does Not Exist"
	exit 1
else
	CA_CERT=`cat ${CA_CERT}`
fi

# Verify User Certs Exists
if [ ! -e "${T_PKI}/${U_NAME/ /_}.key.pem" ]; then
	echo "User Key Does Not Exist"
	exit 1
else
	C_KEY=`cat ${T_PKI}/${U_NAME_B}.key.pem | sed -ne '/BEGIN RSA/,/END RSA/p'`
fi

if [ ! -e "${T_PKI}/${U_NAME_B}.cert.pem" ]; then
	echo "User Key Does Not Exist"
	exit 1
else
	C_CERT=`cat ${T_PKI}/${U_NAME_B}.cert.pem`
fi



# Strip UID, Group, Server, Client Key, Client Cert, CA Cert,
T_UID=`echo ${U_INFO/\/\///} | awk -F"/" '{print $5}'`
T_ORG=`echo ${U_INFO/\/\///} | awk -F"/" '{print $3}'`
T_SERVER=`taskd config --data ${T_DATA} | grep server\ | awk '{print $2}'`
#C_KEY=`cat ${T_DATA}/user_certs/${U_NAME/ /_}.key.pem | sed -ne '/BEGIN RSA/,/END RSA/p'`
#C_CERT=`cat ${T_DATA}/user_certs/${U_NAME/ /_}.cert.pem`
#CA_CERT=`cat ${CA_CERT}`

#echo $T_UID
#echo $T_ORG
#echo $T_SERVER
#echo $C_KEY
#echo $C_CERT
#echo $CA_CERT

cat > ./${U_NAME_B} << EOF
username: ${U_NAME}
org: ${T_ORG}
user key: ${T_UID}
server: ${T_SERVER}
client.cert:
${C_CERT}
client.key:
${C_KEY}
ca.cert:
${CA_CERT}
EOF
