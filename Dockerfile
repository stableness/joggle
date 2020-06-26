ARG NV=14
FROM node:${NV}-alpine





RUN echo start \
\
    && REPO='/etc/apk/repositories' \
    && sed -i 's|http://dl-cdn.alpinelinux.org|https://ftp.yzu.edu.tw/Linux|g' $REPO \
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





RUN npm install





CMD [ "npm", "start" ]
ENTRYPOINT [ "/sbin/tini", "-v", "--" ]
