FROM node:7-alpine
LABEL maintainer "awesinine"

ENV BOTDIR /opt/bot

# Install Hubot generator
RUN \
  apk add --no-cache jq && \
  npm install -g --production --silent coffee-script generator-hubot yo && \
  mkdir /hubot && chown node:node /hubot

WORKDIR ${BOTDIR}

USER node

RUN \
  yo --no-insight hubot --name=hubot-container --defaults && \
  rm -f hubot-scripts.json && \
  sed -i '/npm install/d' bin/hubot && \
  npm install --save --production --silent \
    hubot-slack \
    hubot-auth \
    hubot-env \
    twit

ENTRYPOINT ["./bin/hubot"]
