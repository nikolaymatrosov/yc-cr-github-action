FROM node:16 AS builder
COPY ./package.json /
COPY ./tsconfig.json /
COPY ./package-lock.json /
COPY ./src ./src
RUN npm i --verbose
RUN npm run build

FROM node:16
COPY --from=builder /package*.json /
RUN npm i --verbose --only=production
COPY --from=builder /dist /

EXPOSE 3000

CMD node index.js