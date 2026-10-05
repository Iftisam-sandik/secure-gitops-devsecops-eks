ARG ALPINE_VERSION=3.24

FROM node:24-alpine${ALPINE_VERSION} AS builder

WORKDIR /app

COPY package.json package-lock.json ./
COPY client/package.json ./client/package.json
COPY server/package.json ./server/package.json

RUN npm ci

COPY server ./server

RUN npm run build --workspace=server


FROM node:24-alpine${ALPINE_VERSION} AS dependencies

WORKDIR /app

COPY package.json package-lock.json ./
COPY client/package.json ./client/package.json
COPY server/package.json ./server/package.json

RUN npm ci \
      --omit=dev \
      --workspace=server \
      --include-workspace-root=false \
    && npm cache clean --force


FROM alpine:${ALPINE_VERSION} AS runtime

WORKDIR /app

ENV NODE_ENV=production

RUN apk add --no-cache libstdc++ \
    && addgroup -g 1000 node \
    && adduser -u 1000 -G node -s /bin/sh -D node \
    && chown node:node /app

COPY --from=builder /usr/local/bin/node /usr/local/bin/node

COPY --from=dependencies /app/node_modules ./node_modules

COPY server/package.json ./server/package.json
COPY --from=builder /app/server/dist ./server/dist

USER 1000:1000

EXPOSE 3001

CMD ["node", "server/dist/index.js"]
