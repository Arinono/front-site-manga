# Let's start very simple
FROM node:latest

WORKDIR /app
COPY . .
RUN npm i
RUN npm run build

ENTRYPOINT [ "npx", "-y", "serve", "/app/dist" ]
# Obviousily this one has lots of issues.
# To start with, I could install dependencies with the `--prod` flag skip
# the dev dependencies. But I won't because your setup is broken (tailwindcss is
# not a dev dep :3)
# Then, the topic of this part, it lack layers.

###

FROM node:latest

WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm i
COPY . .
RUN npm run build

# And the delete if I want to be clean
RUN rm -rf src package.json package-lock.json tailwind.config.js babel.config.js
# etc

ENTRYPOINT [ "npx", "-y", "serve", "/app/dist" ]

###

# Then one last easy step would be to use a smaller base image,
# such as `node:alpine`
