# Example for 52°North Image and Container Label Specification

The [specification for image and Container labels](https://wiki.52north.org/Documentation/ImageAndContainerLabelSpecification) specifies a minimal set of labels required for

- images
- container
- volumes

Details can be found in our wiki. Please feel invited to provide comments.

This repository provides pratical instructions how to implement this specification.

# Instructions

* **Build the image**

  Just checkout this repository and perform the following command line:

  ```
  docker build -t 52n-label-test:latest --build-arg GIT_COMMIT=$(git rev-parse -q --verify HEAD) --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") .
  ```
* **Verify the labels**

  ```
  docker inspect --format='{{range $k, $v := .ContainerConfig.Labels}} {{- printf "%s = \"%s\"\n" $k $v -}} {{end}}' 52n-label-test:latest
  ```

  The result should look like this:

  ```
  maintainer = "Jürrens, Eike Hinderk <e.h.juerrens@52north.org>"
  org.opencontainers.image.authors = "Jürrens, Eike Hinderk <e.h.juerrens@52north.org>"
  org.opencontainers.image.created = "1952-08-23T11:09:31Z"
  org.opencontainers.image.description = "Example for labelling images and container following https://wiki.52north.org/Documentation/ImageAndContainerLabelSpecification"
  org.opencontainers.image.licenses = "GPL-3.0-or-later"
  org.opencontainers.image.ref.name = "52north/label-example-1.0.0"
  org.opencontainers.image.revision = "5da05aca171acf7fd70183271e347c31d87a5f19"
  org.opencontainers.image.title = "52°North Label Example Image"
  org.opencontainers.image.url = "https://github.com/52North/label-spec.git"
  org.opencontainers.image.vendor = "52°North GmbH"
  org.opencontainers.image.version = "1.0.0"
  ```

* **Start container and add the required labels**

  Check the required labels for running containers and add them to your run command:

  ```bash
  docker run \
    --detach \
    --name 52n-label-test \
    --label org.52north.contact="e.h.juerrens+52n-label-test-on-$(hostname -f)@52north.org" \
    --label org.52north.context="local testing" \
    --label org.52north.end-of-life="$(date -d '+1 hour' -u +"%Y-%m-%dT%H:%M:%SZ")" \
    52n-label-test:latest
  ```

  For a coloured output, use [jq](https://stedolan.github.io/jq/) to show the labels of the container:

  ```
  docker inspect 52n-label-test | jq -r '.[0].Config.Labels'
  ```

  ```json
  {
    "maintainer": "Jürrens, Eike Hinderk <e.h.juerrens@52north.org>",
    "org.52north.contact": "e.h.juerrens+52n-label-test-on-makatea@52north.org",
    "org.52north.context": "local testing",
    "org.52north.end-of-life": "1952-08-23T12:54:27Z",
    "org.opencontainers.image.authors": "Jürrens, Eike Hinderk <e.h.juerrens@52north.org>",
    "org.opencontainers.image.created": "2020-12-03T11:41:15Z",
    "org.opencontainers.image.description": "Example for labelling images and container following https://wiki.52north.org/Documentation/ImageAndContainerLabelSpecification",
    "org.opencontainers.image.licenses": "GPL-3.0-or-later",
    "org.opencontainers.image.ref.name": "52north/label-example-1.0.0",
    "org.opencontainers.image.revision": "5da05aca171acf7fd70183271e347c31d87a5f19",
    "org.opencontainers.image.title": "52°North Label Example Image",
    "org.opencontainers.image.url": "https://github.com/52North/label-spec.git",
    "org.opencontainers.image.vendor": "52°North GmbH",
    "org.opencontainers.image.version": "1.0.0"
  }
  ```

  At the end, **do not** forget to stop and remove the container, or it will print dots for ever:

  ```
  docker kill 52n-label-test && docker rm 52n-label-test
  ```