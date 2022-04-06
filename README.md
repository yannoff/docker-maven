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

_Maven assumes the .m2 directory is always in `${user.home}/.m2` path._

_So the place of this directory mount in the container is crucial for `maven` to find id._

#### Example: running as `root`

The `HOME` environment variable is set to `/root`, so:

```bash
docker run -v ~/.m2:/root/.m2 ...
```

#### Example: running as an arbitrary user

Given the user is unknwon to the system, `HOME` is set to `/`:

```bash
docker run -u 1000:1000 -v ~/.m2:/.m2 ...
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
MAVEN_MIRROR | https://dlcdn.apache.org | Base repository URL for maven binaries download
APK_PACKAGES |`bash git openssh` | Base APK package set to be bundled in the image
MAVEN_HOME | `usr/share/maven` | Maven binary install directory
LANG | `C.UTF-8` | Initial value for the `LANG` env var
WORKDIR | `/workspace` | Working directory of the built image

## Credits

This work was inspired by the [carlossg/docker-maven](https://github.com/carlossg/docker-maven) official repository sources.

## License

Licensed under the [MIT License](LICENSE).
