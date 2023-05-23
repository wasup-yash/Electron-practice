
FROM node:19-bullseye

RUN apt-get update
RUN apt-get update && apt-get install \
    git libdrm2 libx11-xcb1 libxcb-dri3-0 libxtst6 libnss3 libatk-bridge2.0-0 libgtk-3-0 libxss1 libasound2 libgbm1 \
    -yq --no-install-suggests --no-install-recommends \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/app/ 

WORKDIR /home/app/
USER node

COPY . /home/app/

USER root

RUN chown -R node:node /home/app/

RUN rm -rf /home/app/node_modules

USER node

RUN npm install --save-dev electron
RUN npm install install
RUN npx electron-rebuild

USER root

RUN chown root /home/app/node_modules/electron/dist/chrome-sandbox
RUN chmod 4755 /home/app/node_modules/electron/dist/chrome-sandbox

USER node

CMD ["npm", "start"] 