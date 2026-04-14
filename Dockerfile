FROM node:lts-alpine3.23 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Starts a completely new stage. Everything from the first stage (the
# node filesystem, npm install results, your source code, etc.) is discarded.
# Only what you explicitly COPY --from=builder survives
# into the final image.
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

