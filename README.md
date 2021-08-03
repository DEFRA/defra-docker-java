# Docker Java

This repository contains Java parent Docker image source code for Defra.

The following table lists the versions of Java available, and the parent Java image they are based on:

| Java version  | Parent image         |
| ------------- | -------------------- |
| 8u302         | openjdk:8u302-slim   |
| 11.0.12       | openjdk:11.0.12-slim |

[Examples](./example) are provided to show how parent images can be extended for different types of services. These should be a good starting point for building Java services conforming to Defra standards.

## Building images locally

To build the images locally, run:
```
docker build . --no-cache
```

This will build an image using the default `BASE_VERSION` as set in the [Dockerfile](Dockerfile).

## Internal CA certificates

The image includes the certificate for the internal [CA](https://en.wikipedia.org/wiki/Certificate_authority) so that traffic can traverse the network without encountering issues.

## Versioning

Images should be tagged according to the Dockerfile version and the version of Java on which the image is based. For example, for Dockerfile version `1.0.0` based on Java `11.0.12-slim`, the built image would be tagged `1.0.0-java11.0.12-slim`.

Other tags are also pushed, e.g. `jdk-8` & `jre-11` to allow pointing at the latest image for that sdk version, together with `latest`.

## Example files

`Dockerfile.service` - This is an example project that runs a web service.

## CI/CD

On commit GitHub Actions will build the `java` image for the Java versions listed in the [image-matrix.json](image-matrix.json) file, and perform a vulnerability scan, as described below.

In addition a commit to the master branch will push the images to the [defradigital](https://hub.docker.com/u/defradigital) organisation in Docker Hub using the version tag specified in the [JOB.env](JOB.env) file. This version tag is expected to be manually updated on each release.

The Java version marked as `latest` in the [image-matrix.json](image-matrix.json) will be tagged as the `latest` image in Docker Hub.

## Image vulnerability scanning


A GitHub Action runs a nightly Anchore Engine scan of the image published to Docker, and will build and scan pre-release images on push. At present only the latest JDK 11 image is scanned. Scanning of the JRE & 8 images will be added in the future.

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
