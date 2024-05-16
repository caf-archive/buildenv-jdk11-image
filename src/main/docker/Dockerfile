#
# Copyright 2019-2024 Open Text.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# Public maven image that contains the mvn-entrypoint.sh and settings-docker.xml files required
#
FROM ${projectDockerRegistry}/library/maven AS public_maven

#
# The actual image definition
#
FROM ${projectDockerRegistry}/cafapi/opensuse-jdk11

# Copy the required files from public maven image
COPY --from=public_maven /usr/local/bin/mvn-entrypoint.sh /usr/local/bin/
COPY --from=public_maven /usr/share/maven/ref/settings-docker.xml /usr/share/maven/ref/

# Confirm hash values of required files and configure maven
RUN zypper -n refresh && \
    zypper -n update && \
    zypper -n install tar gzip && \
    echo d79812f7c4a5ee5e9509351ae14e84649cbe27d2fa069f433f32415a6a12d90ec52c49be09ff08af8a7aae48cc3ffecaee804a5e25547c4e3042d1f10c08c555 \
         /usr/local/bin/mvn-entrypoint.sh | sha512sum -c - && \
    echo 6e29de1b58e17a54465d07eaa18bbde60b774bd17b1d7efcd2bc8dbbaf91c62abe8acb3933c5c27e630dc3b118453d2d0ab7fb206cf403e204708555bb0a6059 \
         /usr/share/maven/ref/settings-docker.xml | sha512sum -c - && \
    mkdir -p /usr/share/maven /usr/share/maven/ref && \
    curl -fsSL -o /tmp/apache-maven.tar.gz https://apache.osuosl.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz && \
    echo deaa39e16b2cf20f8cd7d232a1306344f04020e1f0fb28d35492606f647a60fe729cc40d3cba33e093a17aed41bd161fe1240556d0f1b80e773abd408686217e \
         /tmp/apache-maven.tar.gz | sha512sum -c - && \
    tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 && \
    rm -f /tmp/apache-maven.tar.gz && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG /root/.m2

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["mvn"]
