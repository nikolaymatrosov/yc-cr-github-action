FROM node:16-alpine AS builder
RUN apk --no-cache add --virtual native-deps \
  g++ gcc libgcc libstdc++ linux-headers autoconf automake make nasm python git && \
  npm install --quiet node-gyp -g
COPY ./package.json /
COPY ./package-lock.json /
RUN npm i --verbose --only=production

FROM node:16-alpine
WORKDIR /root/
COPY --from=builder /node_modules /app/node_modules
COPY ./dist/app /app
CMD node /app/index.js