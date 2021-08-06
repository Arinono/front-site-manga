# This was already here IIRC when I deleted everything, but let's do it again anyways

FROM node:latest as builder

WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm i
COPY . .
RUN npm run build

FROM nginx as server

COPY --from=builder /app/dist /usr/share/nginx/html

# tadaa
