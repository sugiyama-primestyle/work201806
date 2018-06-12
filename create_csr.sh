#!/bin/bash

# variable declaration
YYYY=$1
TARGET_DIR=ssl${YYYY}
C_NAME=$2

[ $# -ne 2 ] && echo "Error" && echo "Usage: ./`basename $0` <YYYY> <COMMON_NAME>" && exit 1
[ ! -d ${TARGET_DIR} ] && mkdir ${TARGET_DIR}
cd ${TARGET_DIR}
[ -f ${C_NAME}.key ] && echo "Error" && echo "${C_NAME}.key exist." && exit 2
echo "# Make private key"
openssl genrsa -des3 -out ${C_NAME}.key 2048

clear

echo "# Make CSR"
openssl req -new -key ${C_NAME}.key -out ${C_NAME}.csr

clear

echo "# Cancel passphrease"
cp -p ${C_NAME}.key ${C_NAME}.key.org
[ $? -ne 0 ] && echo "Cancel passphrease Error." && exit 3
openssl rsa -in ${C_NAME}.key -out ${C_NAME}.key 
[ $? -ne 0 ] && echo "Cancel passphrease Error." && exit 4

clear
cat ${C_NAME}.csr

exit 0
