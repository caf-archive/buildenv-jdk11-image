#
# Copyright 2019-2020 Micro Focus or one of its affiliates.
#
# The only warranties for products and services of Micro Focus and its
# affiliates and licensors ("Micro Focus") are set forth in the express
# warranty statements accompanying such products and services. Nothing
# herein should be construed as constituting an additional warranty.
# Micro Focus shall not be liable for technical or editorial errors or
# omissions contained herein. The information contained herein is subject
# to change without notice.
#
# Contains Confidential Information. Except as specifically indicated
# otherwise, a valid license is required for possession, use or copying.
# Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
# Computer Software Documentation, and Technical Data for Commercial
# Items are licensed to the U.S. Government under vendor's standard
# commercial license.
#

#
# Public maven image that contains the mvn-entrypoint.sh and settings-docker.xml files required
#
FROM maven:3.6.2-jdk-8 AS public_maven

#
# Base on the standard image provided by the Release Engineering team
#
FROM cafapi/opensuse-jdk8:1

ARG MAVEN_VERSION=3.6.2
ARG USER_HOME_DIR="/root"
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

# Copy the required files from public maven image
COPY --from=public_maven /usr/local/bin/mvn-entrypoint.sh /usr/local/bin/
COPY --from=public_maven /usr/share/maven/ref/settings-docker.xml /usr/share/maven/ref/

# Confirm hash values of required files and configure maven
RUN zypper -n install tar gzip \
  && echo "d79812f7c4a5ee5e9509351ae14e84649cbe27d2fa069f433f32415a6a12d90ec52c49be09ff08af8a7aae48cc3ffecaee804a5e25547c4e3042d1f10c08c555 /usr/local/bin/mvn-entrypoint.sh" | sha512sum -c - \
  && echo "6e29de1b58e17a54465d07eaa18bbde60b774bd17b1d7efcd2bc8dbbaf91c62abe8acb3933c5c27e630dc3b118453d2d0ab7fb206cf403e204708555bb0a6059 /usr/share/maven/ref/settings-docker.xml" | sha512sum -c - \
  && mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "d941423d115cd021514bfd06c453658b1b3e39e6240969caf4315ab7119a77299713f14b620fb2571a264f8dff2473d8af3cb47b05acf0036fc2553199a5c1ee /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["mvn"]

#
# Tag the image
#
ARG BUILD_NUMBER
ARG BUILD_DATE
ARG GIT_REPO
ARG GIT_BRANCH
ARG GIT_COMMIT

LABEL Build.Number="$BUILD_NUMBER" \
      Build.Date="$BUILD_DATE" \
      Git.Repo="$GIT_REPO" \
      Git.Branch="$GIT_BRANCH" \
      Git.Commit="$GIT_COMMIT"
