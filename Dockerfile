# pull the Node.js Docker image
FROM node:16-slim AS builder

# create the directory inside the container
WORKDIR /usr/src/app


# O.S. packages install
RUN apt-get -qy update && apt-get -qy install g++ make python3 autoconf automake libtool openssl

# copy source
COPY . .

ARG DATABASE_URL
ENV DATABASE_URL=${DATABASE_URL}

# run npm install
RUN yarn install --prefer-offline --frozen-lockfile && \
    yarn generate && \
    yarn build

# our app is running on port 3333 within the container, so need to expose it
EXPOSE 3333


RUN ["chmod", "+x", "./docker-scripts/entrypoint.sh"]
RUN ["chmod", "+x", "./docker-scripts/wait-for-it.sh"]

ENTRYPOINT ["./docker-scripts/entrypoint.sh"]
