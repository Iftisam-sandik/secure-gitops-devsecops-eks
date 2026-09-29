FROM node:24-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json ./
COPY client/package.json ./client/package.json
COPY server/package.json ./server/package.json

RUN npm ci

COPY server ./server

RUN npm run build --workspace=server


FROM node:24-alpine AS runtime

WORKDIR /app

ENV NODE_ENV=production

COPY package.json package-lock.json ./
COPY client/package.json ./client/package.json
COPY server/package.json ./server/package.json

RUN npm ci --omit=dev --workspace=server --include-workspace-root=false \
    && npm cache clean --force

COPY --from=builder /app/server/dist ./server/dist

USER node

EXPOSE 3001

CMD ["node", "server/dist/index.js"]
