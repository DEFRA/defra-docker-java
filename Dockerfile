# Set default values for build arguments
ARG DEFRA_VERSION=1.2.0
ARG BASE_VERSION=21-jdk-noble

FROM eclipse-temurin:$BASE_VERSION AS production

ARG BASE_VERSION
ARG DEFRA_VERSION

# Install Internal CA certificate
RUN apt-get update -o APT::Update::Error-Mode=any && apt install -y ca-certificates && apt-get clean
COPY certificates/internal-ca.crt /usr/local/share/ca-certificates/internal-ca.crt
RUN chmod 644 /usr/local/share/ca-certificates/internal-ca.crt && update-ca-certificates

RUN keytool -noprompt -keystore $([ -d $JAVA_HOME/lib/security ] && echo $JAVA_HOME || echo $JAVA_HOME/jre)/lib/security/cacerts -storepass changeit -importcert -alias defraRootCertificate -file /usr/local/share/ca-certificates/internal-ca.crt

# Update all packages
RUN apt-get -o APT::Update::Error-Mode=any -y upgrade && apt-get clean

# Never run as root, default to the jreuser user. Group 1000 taken by Ubuntu in newer images.
# Only bumbing group ID if taken for backwards compatibility of older images.
RUN RUN GID=$(getent group 1000 >/dev/null && echo 1010 || echo 1000) && \
    groupadd --gid $GID jreuser && \
    UID=$(getent passwd 1000 >/dev/null && echo 1010 || echo 1000) && \
    useradd --uid $UID --gid $GID --shell /bin/bash --create-home jreuser

# Default workdir should be owned by the default user
WORKDIR /home/jreuser

# Label images to aid searching
LABEL uk.gov.defra.java.java-version=$BASE_VERSION \
      uk.gov.defra.java.version=$DEFRA_VERSION \
      uk.gov.defra.java.repository=defradigital/java
