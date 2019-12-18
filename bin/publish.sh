#!/bin/bash

if [[ "$1" == "-h" || "$1" == "--help" || -z "$1" || -z "$2" ]]; then
    echo "usage: $0 <openssl-version> <openssl-fips-version>"
    exit 1
fi


DATETIME_TAG=$(TZ="UTC" date +"%Y%m%d%H%m")
DATETIME_MSG=$(TZ="UTC" date +"%d %B %Y %H:%m %Z")

git tag \
  -m "OpenSSL Version: $1" \
  -m "OpenSSL FIPS Version: $2" \
  -m "Release Date/Time: $DATETIME_MSG" \
  -s ${1}-${2}-${DATETIME_TAG}
