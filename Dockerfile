###################
# BUILD FOR DEVELOPMENT
###################

FROM node:18-alpine As development
ENV NODE_ENV development
WORKDIR /usr/app
COPY --chown=node:node ./API/package*.json ./MyFullstackApp/API/
COPY --chown=node:node ./client/package*.json ./MyFullstackApp/client/
USER node
RUN cd ./MyFullstackApp/client && npm ci
RUN cd ./MyFullstackApp/API && npm ci
COPY --chown=node:node ./API ./MyFullstackApp/API/
COPY --chown=node:node ./client ./MyFullstackApp/client/

###################
# BUILD FOR PRODUCTION
###################

FROM node:18-alpine As build
WORKDIR /usr/app
COPY --chown=node:node ./API/package*.json ./MyFullstackApp/API/
COPY --chown=node:node ./client/package*.json ./MyFullstackApp/client/

COPY --chown=node:node --from=development /usr/app/MyFullstackApp/API/node_modules ./MyFullstackApp/API/node_modules
COPY --chown=node:node --from=development /usr/app/MyFullstackApp/client/node_modules ./MyFullstackApp/client/node_modules
COPY --chown=node:node ./API ./MyFullstackApp/API/
COPY --chown=node:node ./client ./MyFullstackApp/client/

USER node
RUN cd ./MyFullstackApp/API && npm run build 
RUN cd ./MyFullstackApp/client && npm run build 

ENV NODE_ENV production
RUN cd ./MyFullstackApp/API && npm ci --only=production && npm cache clean --force 
RUN cd ./MyFullstackApp/client && npm ci --only=production && npm cache clean --force

###################
# PRODUCTION
###################

FROM node:18-alpine As production
WORKDIR /usr/app
COPY --chown=node:node --from=build /usr/app/MyFullstackApp/API/node_modules ./MyFullstackApp/API/node_modules
# COPY --chown=node:node --from=build /usr/app/MyFullstackApp/client/node_modules ./MyFullstackApp/client/node_modules

COPY --chown=node:node --from=build /usr/app/MyFullstackApp/API/.env ./MyFullstackApp/API/dist/.env

COPY --chown=node:node --from=build /usr/app/MyFullstackApp/API/dist ./MyFullstackApp/API/dist
COPY --chown=node:node --from=build /usr/app/MyFullstackApp/client/build ./MyFullstackApp/client/build

CMD [ "node", "MyFullstackApp/API/dist/main.js" ]
