# Base image: Node.js LTS (24) on Debian slim
FROM node:24-slim
# update OS, install bash and clean all installation files
RUN apt-get update \
    && apt-get install -y bash \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
# create directory server and ...
RUN mkdir /server
# set it as working directory
WORKDIR /server
# copy all local files in the backend into
# working directory
COPY backend/ .
# install all nodejs dependencies
RUN npm install
# expose port 3000 of the app
EXPOSE 3000
# run server
CMD ["npm", "run", "server"]
