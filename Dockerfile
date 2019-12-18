####
#   Copyright 2019 Bradyn Poulsen
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
####

FROM debian:buster-slim as builder

RUN apt-get update \
    && apt-get install -y \
        curl \
        gcc \
        gpg \
        make \
        patch \
        libpcre2-dev \
        perl \
        wget \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

ARG OPENSSL_FIPS_VERSION
RUN wget https://www.openssl.org/source/openssl-fips-${OPENSSL_FIPS_VERSION}.tar.gz \
    && tar oxvfm openssl-fips-${OPENSSL_FIPS_VERSION}.tar.gz \
    && cd openssl-fips-${OPENSSL_FIPS_VERSION} \
    && ./config \
    && make \
    && make install \
    && cd .. \
    && rm -rf openssl-fips-${OPENSSL_FIPS_VERSION}*


ARG OPENSSL_VERSION
RUN wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz \
    && tar oxvfm openssl-${OPENSSL_VERSION}.tar.gz \
    && cd openssl-${OPENSSL_VERSION} \
    && ./config fips shared --openssldir=/usr/local/ssl --with-fipsdir=/usr/local/ssl/fips-2.0 --with-fipslibdir=/usr/local/ssl/fips-2.0/lib/ \
    && make depend \
    && make \
    && make install \
    && cd .. \
    && rm -rf openssl-${OPENSSL_VERSION}* \
    && rm -rf /usr/local/ssl/man

RUN find /usr/local/ssl

FROM scratch
COPY --from=builder /usr/local/ssl /usr/local/ssl
