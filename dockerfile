FROM node:14-alpine

RUN npm install

COPY . .

RUN npm run build

CMD ["npm", "start"]