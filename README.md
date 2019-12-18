# openssl-fips-dist Docker Image

This image provides a debian-based OpenSSL build with the FIPS wrapper.

## Usage

Utilize this image as a file source for use in your own `Dockerfile`:

```dockerfile
FROM debian:buster-slim

COPY --from=bradynpoulsen/openssl-fips-dist:<version> /usr/local/ssl /usr/local/ssl
```

# Building

Build arguments:
 - `OPENSSL_VERSION`: The OpenSSL version to pull down and build
 - `OPENSSL_FIPS_VERSION`: The OpenSSl FIPS wrapper version to pull down and build

```bash
$ docker build --build-arg OPENSSL_VERSION=<openssl-version> --build-arg OPENSSL_FIPS_VERSION=<openssl-fips-version> .
```

## Version Strategy

This repository uses the following tagging strategy: `<openssl-version>-<openssl-fips-version>-<release-datetime>`
 - `<openssl-version>` (ie, `1.0.2t`)
 - `<openssl-fips-version>` (ie, `2.0.16`)
 - `<release-datetime>` (ie, `201912251230`)

Docker Hub automated builds is automatically configured to pull out the `<openssl-version>` and `<openssl-fips-version>`
from the tag to provide as build arguments.

# License

```
Copyright 2019 Bradyn Poulsen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```