FROM alpine:3.12 as build

ARG PROXY





RUN echo start \
\
    && REPO='/etc/apk/repositories' \
    && sed -i 's|http://dl-cdn.alpinelinux.org|https://mirrors.aliyun.com|g' $REPO \
\
    && apk add --no-cache --virtual .build-deps \
            curl          \
\
    && rm -rf /var/cache/apk/* /tmp/* \
\
&& echo end





WORKDIR /opt/kcp





RUN echo start \
\
    &&   OS="linux-arm64" \
    &&  VER="20200409" \
    && FILE="kcptun-$OS-$VER.tar.gz" \
    && LINK="https://github.com/xtaci/kcptun/releases/download/v$VER/$FILE" \
\
    && export http_proxy=${PROXY} \
    && export https_proxy=${PROXY} \
\
    && curl -Ls $LINK | tar xzv \
\
&& echo end









FROM alpine:3.12

COPY --from=build /opt/kcp/client* /bin/client

