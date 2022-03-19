# yannoff/docker-maven

A set of Alpine-based version of maven docker images.

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
docker run --rm -it -v $PWD:/workspace -v ~/.m2:/root/.m2 yannoff/maven:3.8-openjdk-16 deploy
```

## Customized build

_Example: Building with a different maven version_

```yaml
version: '3.6'
services:
    maven:
        build:
            context: https://github.com/yannoff/docker-maven.git#<version>:/
            args:
                MAVEN_VERSION: 3.6.3

```

### Build arguments

Name|Default|Description
---|---|---
JDK_VERSION | `none` | The OpenJDK base image major version to extend from _(eg: `16` for `openjdk:16-alpine`)_
MAVEN_VERSION | `3.8.5` |Exact version of the maven binary
USER_HOME | `/root` |
MAVEN_MIRROR | https://dlcdn.apache.org/maven/maven-3 | Base repository URL for maven binaries download
APK_PACKAGES |`bash findutils git` | Base APK package set to be bundled in the image
MAVEN_HOME | `usr/share/maven` | Maven binary install directory
LANG | `C.UTF-8` | Initial value for the `LANG` env var
WORKDIR | `/workspace` | Working directory of the built image

## Credits

This work is derived from the [carlossg/docker-maven](https://github.com/carlossg/docker-maven) official repository sources.

## License

Licensed under the [MIT License](LICENSE).
