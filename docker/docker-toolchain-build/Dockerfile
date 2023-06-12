FROM ubuntu:latest as builder

WORKDIR /dependencies
COPY gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 .

WORKDIR /home/dev
RUN apt-get update && apt-get install -y lbzip2 && \
    tar xf /dependencies/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 && \
    rm -rf gcc-arm-none-eabi-8-2019-q3-update/share/doc

FROM frolvlad/alpine-glibc:latest
RUN apk add --no-cache \
    python3 \
    py3-setuptools \
    scons \
    ruby ruby-bundler \
    gcc musl-dev &&\
    apk update

COPY --from=builder /home/dev/ /home/dev/
ENV PATH="/home/dev/gcc-arm-none-eabi-8-2019-q3-update/bin:${PATH}"

WORKDIR /usr/project

CMD ["scons", "-j16"]