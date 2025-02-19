# Copyright (C) 2020-2020 52°North Initiative for Geospatial Open Source
# Software GmbH
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 2 as published
# by the Free Software Foundation.
#
# If the program is linked with libraries which are licensed under one of
# the following licenses, the combination of the program with the linked
# library is not considered a "derivative work" of the program:
#
#     - Apache License, version 2.0
#     - Apache Software License, version 1.0
#     - GNU Lesser General Public License, version 3
#     - Mozilla Public License, versions 1.0, 1.1 and 2.0
#     - Common Development and Distribution License (CDDL), version 1.0
#
# Therefore the distribution of the program linked with libraries licensed
# under the aforementioned licenses, is permitted by the copyright holders
# if the distribution is compliant with both the GNU General Public
# License version 2 and the aforementioned licenses.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
# Public License for more details.
#
# build with
#
#      --build-arg GIT_COMMIT=$(git rev-parse -q --verify HEAD)
#      --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
#
FROM alpine:latest

ENV VERSION=1.0.0

LABEL maintainer="Jürrens, Eike Hinderk <e.h.juerrens@52north.org>" \
      org.opencontainers.image.authors="Jürrens, Eike Hinderk <e.h.juerrens@52north.org>" \
      org.opencontainers.image.url="https://github.com/52North/TBD.git" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.vendor="52°North GmbH" \
      org.opencontainers.image.licenses="GPL-3.0-or-later" \
      org.opencontainers.image.ref.name="52north/label-example-1.0.0" \
      org.opencontainers.image.title="52°North Label Example Image" \
      org.opencontainers.image.description="Example for labelling images and container following https://wiki.52north.org/Documentation/ImageAndContainerLabelSpecification"

ARG GIT_COMMIT
LABEL org.opencontainers.image.revision="${GIT_COMMIT}"

ARG BUILD_DATE
LABEL org.opencontainers.image.created="${BUILD_DATE}"

CMD /bin/sh -c 'while true; do echo -e ".\c"; sleep 3; done'
