FROM node:22 AS builder

ENV NODE_ENV production
WORKDIR /app

COPY package*.json ./

RUN npm ci

# Copy source
COPY . .

RUN npm run build

FROM node:22-slim AS production


ENV NODE_ENV production

EXPOSE 3000

WORKDIR /app
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

COPY --from=builder /app/lib ./lib
COPY --from=builder /app/data ./data
COPY --from=builder /app/app ./app

CMD ["npm", "run", "start"]