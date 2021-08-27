!not-ready-for-release!

#### Version Number
${version-number}

#### New Features
- **SCMOD-8516**: Extend the security hardening of Java base images by disabling TLS algorithms mentioned [here](https://github.com/CAFapi/opensuse-java8-images/blob/develop/src/main/docker/disableWeakTlsAlgorithms.patch)

#### Known Issues
- None

#### Breaking Changes
- **SCMOD-8516**: Extend the security hardening of Java base images by disabling TLS algorithms mentioned [here](https://github.com/CAFapi/opensuse-java8-images/blob/develop/src/main/docker/disableWeakTlsAlgorithms.patch)
- **SCMOD-7700**: Stops the docker container if the execution of any of the startup scripts fail instead of ignoring it.
- **SCMOD-14638**: Docker image has been renamed from `opensuse-jdk-maven` to `buildenv-jdk8`.
