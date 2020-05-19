FROM node:13.6.0-alpine3.10
WORKDIR /open-oracle
RUN wget https://github.com/ethereum/solidity/releases/download/v0.6.6/solc-static-linux -O /usr/local/bin/solc && chmod +x /usr/local/bin/solc
RUN apk update && apk add --no-cache --virtual .gyp \
    python \
    make \
    g++ \
    yarn \
    nodejs \
    git

RUN yarn global add node-gyp npx
COPY package.json /open-oracle/package.json

RUN yarn install

ENV PROVIDER PROVIDER
COPY contracts contracts
COPY tests tests
COPY saddle.config.js saddle.config.js
RUN npx saddle compile

ENTRYPOINT []
CMD npx saddle
