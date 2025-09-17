# Docker Java

This repository contains Java parent Docker image source code for Defra.

The following table lists the versions of Java available, and the parent Java image they are based on:

| Java version  | Parent image             |
| ------------- | ------------------------ |
| 11            | eclipse-temurin:11-jammy |
| 17            | eclipse-temurin:17-jammy |
| 21            | eclipse-temurin:21-jammy |
| 21            | eclipse-temurin:21-noble |

[Examples](./example) are provided to show how parent images can be extended for different types of services. These should be a good starting point for building Java services conforming to DEFRA standards.

## Building images locally

To build the images locally, run:
```
docker build . --no-cache
```

This will build an image using the default `BASE_VERSION` as set in the [Dockerfile](Dockerfile).

## Internal CA certificates

The image includes the certificate for the internal [CA](https://en.wikipedia.org/wiki/Certificate_authority) so that traffic can traverse the network without encountering issues.

## Versioning

Images should be tagged according to the Dockerfile version and the version of Java on which the image is based. For example, for Dockerfile version `1.0.0` based on Java `21.0.3`, the built image would be tagged `1.0.0-java21.0.3`. 1.2.0-287-java21-noble

Inmages are tagged according to:
  
  1. Dockerfile version and the version of Java on which the image is based.
  2. The build ID. This has be introduce to maintain immutability (i.e. prevent the opportunity for different builds with the same tag).
  3. Java version.
  4. Ubuntu version

  e.g. `1.2.0-287-java11-jammy`


Other tags are also pushed to allow pointing at the latest image for that jdk/sdk version, together with `latest` e.g 

- `latest` and `latest-jre` - Points to the latest JRE 21 image
- `latest-jdk` - Points to the latest JDK 21 image
- `jre-11`, `jre-17`, `jre-21` - Points to the latest JRE image for that Java major version
- `jre-21-jammy` - Points to the latest JRE image whilst targetting an older OS image.
- `jdk-21-jammy` - Points to the latest JDK image whilst targetting an older OS image.

On commit GitHub Actions will build the `java` image for the Java versions listed in the [image-matrix.json](image-matrix.json) file, and perform a vulnerability scan, as described below.

In addition a commit to the master branch will push the images to the [defradigital](https://hub.docker.com/u/defradigital) organisation in Docker Hub using the version tag specified in the [JOB.env](JOB.env) file. This version tag is expected to be manually updated on each release.

The Java version marked as `latest` in the [image-matrix.json](image-matrix.json) will be tagged as the `latest` image in Docker Hub.

## Image vulnerability scanning

A GitHub Action runs a nightly Anchore Grype scan of the image published to Docker, and will build and scan pre-release images on push. At present the latest Java 8/11/17/21 JDK/JRE images are scanned.

This ensures Defra services that use the parent images are starting from a known secure foundation, and can limit patching to only newly added libraries.

For more details see [Image Scanning](IMAGE_SCANNING.md)

## Licence

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at:

<http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3>

The following attribution statement MUST be cited in your products and applications when using this information.

> Contains public sector information licensed under the Open Government license v3

### About the licence

The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
