# yannoff/docker-maven

A set of Alpine-based version of [maven](https://maven.apache.org/) docker images.

## Precompiled images

_Pre-compiled image are convenient to run on-the-fly maven commands._

### Supported tags

- [`3.8.5-openjdk-19-alpine`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/19/Dockerfile)
, [`3.8.5-openjdk-19`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/19/Dockerfile)
, [`3.8-openjdk-19`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/19/Dockerfile)
, [`latest`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/19/Dockerfile)
- [`3.8.5-openjdk-18-alpine`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/18/Dockerfile)
, [`3.8.5-openjdk-18`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/18/Dockerfile)
, [`3.8-openjdk-18`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/18/Dockerfile)
- [`3.8.5-openjdk-17-alpine`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/17/Dockerfile)
, [`3.8.5-openjdk-17`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/17/Dockerfile)
, [`3.8-openjdk-17`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/17/Dockerfile)
- [`3.8.5-openjdk-16-alpine`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/16/Dockerfile)
, [`3.8.5-openjdk-16`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/16/Dockerfile)
, [`3.8-openjdk-16`](https://github.com/yannoff/docker-maven/tree/3.8/openjdk/16/Dockerfile)


### Usage

_Example: Running a mvn task on the current directory_

```bash
docker run --rm -it -v $PWD:/workspace -v ~/.m2:/root/.m2 yannoff/maven:3.8-openjdk-16 mvn deploy
```

### Note on the `.m2` dir

Maven expects the `.m2` directory to be located in the `${user.home}/.m2` path.

The `mvn` wrapper script bundled in the maven images automatically prepend arguments with the correct `-Duser.home` value, making it easier to run commands as non-root users.

_Anyway the directory must be mounted accordingly in the container._

#### Example: running as `root`

The `HOME` environment variable is set to `/root`:

```bash
docker run -v /path/to/.m2:/root/.m2 ...
```

#### Example: running as an arbitrary user

Given the user is unknwon to the system, `HOME` is set to `/`:

```bash
docker run -u 1000:1000 -v /path/to/.m2:/.m2 ...
```

## Customized build

_Example: Building with a different maven version_

```yaml
version: '3.6'
services:
    maven:
        build:
            context: https://github.com/yannoff/docker-maven.git#3.8/openjdk/18:/
            args:
                MAVEN_VERSION: 3.6.3

```

### Build arguments

Name|Default|Description
---|---|---
JDK_VERSION | `18-jdk` | The OpenJDK base image major version to extend from _(eg: `16` for `openjdk:16-alpine`)_
MAVEN_HOME | `usr/share/maven` | Maven binary install directory
MAVEN_VERSION | `3.8.5` |Exact version of the maven binary
MAVEN_MIRROR | https://dlcdn.apache.org | Base repository URL for maven binaries download
APK_PACKAGES |`bash git openssh` | Base APK package set to be bundled in the image
LANG | `C.UTF-8` | Initial value for the `LANG` env var
WORKDIR | `/workspace` | Working directory of the built image

### Environment variable

Name|Description
---|---
DEBUG | If set, make the entrypoint verbose
LANG | Initial value for the `LANG` env var
WORKDIR | Working directory of the built image
MAVEN_HOME | Maven binary install directory
MAVEN_SHA512 | SHA 512 checksum of the maven binary tarball
MAVEN_URL | Download URL of the maven binary tarball
MAVEN_M2DIR | Path to the `.m2` directory

## Credits

This work was inspired by the [carlossg/docker-maven](https://github.com/carlossg/docker-maven) official repository sources.

## License

Licensed under the [MIT License](LICENSE).
