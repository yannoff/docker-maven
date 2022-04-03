# Advanced usage

## Extending the base image

### Example: adding node

_We leverage the [oznu/alpine-node](https://github.com/oznu/alpine-node) library here:_


```Dockerfile
FROM yannoff/maven:3.8-openjdk-19

ARG NODE=16.14.0

# Install node & clean downloaded tar
RUN apk add --no-cache libgcc libstdc++ \
    && curl -LO https://github.com/oznu/alpine-node/releases/download/${NODE}/node-v${NODE}-linux-x86_64-alpine.tar.gz \
    && tar -xzf node-v${NODE}-linux-x86_64-alpine.tar.gz --same-permissions --no-same-owner -C /usr --strip-components=1 \
    && rm node-v${NODE}-linux-x86_64-alpine.tar.gz
```
