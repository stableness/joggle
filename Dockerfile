ARG NV=14
FROM node:${NV}-alpine





RUN echo start \
\
    && REPO='/etc/apk/repositories' \
    && sed -i -E 's|https?://dl-cdn.alpinelinux.org|https://mirrors.aliyun.com|g' $REPO \
\
    && apk add --no-cache --virtual .build-deps \
            git           \
            tini          \
\
    && rm -rf /var/cache/apk/* /tmp/* \
\
&& echo end





WORKDIR /opt/app

ENV NODE_ENV production
ENV DISABLE_OPENCOLLECTIVE true
ENV ADBLOCK true





COPY .npmrc ./
COPY package.json ./





ARG NPM_REG=https://registry.npmjs.org

RUN npm install --registry ${NPM_REG}





CMD [ "npm", "start" ]
ENTRYPOINT [ "/sbin/tini", "-v", "--" ]

