# Boilerplate for fullstack app

## This is a ready to use boilerplate of fullstack app based on:
- Typescript for Nestjs and React
- Nestjs for backend (API)
- React 18 for frontend (SPA, views)
- API connection to PostgreSQL DB
- Adminer to inspect DB
- Docker with 3 stages to develop, build and deploy for a production the app in Docker containers
- ES Lint, Prettier as linters / code formatters
- Husky as a pre-commit tool
- Jest to run tests
- CommitLint to formatt commit mesages

### How to use:
1. Clone this repo.
2. In the root project folder (most outer one) run npm command ```npm run all-deps-install``` to install all dependencies in all folders necessary.
3. **Now you need to have DOCKER on your machine installed, then to run app for development: ```docker-compose up -d```.**
4. Now the app is listening in the watch mode on ports 3005 (API), 3000 (React SPA) and 8080 (Adminer).
5. To stop app: ```docker compose down```.
6. Remember to populate .env according to .env.example (```./API/<here>```) and to change app name etc.

***To run for build and production you don't need to pre-install any dependencies, just change step 3 to:***
```docker-compose -f docker-compose-production.yml up -d```
and App now is listening on port 80 (API).** In this case other ports are not open and frontend is served as static files by Nestjs.**

**For development you can use npm scripts beeing in root folder:**
1. Code formating: ```npm run format```.
2. Code lint: ```npm run lint```.
3. Run all tests for backend and frontend ```npm run test```.

### How it works:
#### development
In a development mode you have the access to seperate ports for API, Frontend App and Adminer. Docker containers which expose these ports are in watch mode to follow your code base changes and to serve refreshed code as a result. No files from dist or build folders are served at all.
Project is connected to Husky and CommitLint, which not allow to commit any code which:
- not pass ESLint rules,
- not pass project tests
- not pass commit message format
All files fefore commit are formatted by Prettier.

### production
In a production mode, the app construction is based on Nestjs API which is backend for whole ecosystem and also serves static files which have been built during React build process. Static frontend app files are served from ```./client/build``` folder. API (Nestjs app) operates on port 80, API is based on Nest production code from folder ```./API/dist```.  Production image is as small as possible, client folder contains build subfolder only, API folder contains dist and node_moduled subfolders (just with production dependencies).

### What is inside both projects:
### Nestjs:
- clean Nestjs Typescript project +
- working connection with PostgreSQL with use of TypeORM +
- custom main-error-filter catching globally exceptions (check the code to understand how it works) +
- global Validation Pipe with Class Validator +
- Logger Module implemented +
- Config Module implemented +
- App Module connected
- and the app is waiting for your modules.
*App is based on ES2022 - check ES changes.*

### React:
- clead CRA project with Typescript +
- some starting files cleaned +
- changes folders structure
- and the app is waiting for your changes.

---
