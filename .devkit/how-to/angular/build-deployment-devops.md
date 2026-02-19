# Build deployment devops

## Procedure: Configure application environments

### When to use

When setting up environment-specific variables (API endpoints, flags) for development, staging, and production builds.

### Preconditions

- Angular CLI is installed.
- A project has been generated (`ng new` or existing).


### Steps

1. **Generate environment files:** Run `ng generate environments` to create the `src/environments/` folder with base files.
2. **Edit environment.ts:** Open `src/environments/environment.ts` and ensure it sets `production: false` (development configuration).
3. **Add other environment files:** Create `src/environments/environment.development.ts` (or use the generated one). Set `production: false` and other dev-specific variables.
4. **Configure file replacements:** In `angular.json`, under the project’s `build.configurations`, ensure `development` configuration has a `fileReplacements` entry replacing `src/environments/environment.ts` with `src/environments/environment.development.ts`. Repeat for `production` (if needed) and any other environments (e.g., `staging`).
5. **Verify imports:** In your app code, always import from `./environments/environment`. Angular CLI will use the correct file based on the build configuration.

### Validation

- Build the project in different modes:
    - `ng build --configuration development` should build with `environment.development.ts`.
    - `ng build --configuration production` should build using the production environment file defined in angular.json fileReplacements (e.g., `environment.prod.ts`).
- Inspect `dist/` or console logs to confirm correct API URLs or flags are applied from each environment file.


## Procedure: Containerize Angular application with Docker

### When to use

When deploying the Angular app in a Docker container (e.g., for consistent environments or Kubernetes).

### Preconditions

- Docker is installed locally.
- The Angular app is built (`dist/` folder available).


### Steps

1. **Create a Dockerfile:** In the project root, create a file named `Dockerfile`.
2. **Use multi-stage build:** As shown in official Docker guidance, start with a Node image to install dependencies and build:
```
FROM node:alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration production
```

Then use a lightweight server image (e.g. Nginx) to serve the build:

```
FROM nginx:alpine AS serve
COPY --from=build /app/dist/your-app-name /usr/share/nginx/html
# Optionally copy a custom nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

This multi-stage setup ensures the final image contains only the built files and Nginx for serving.
3. **Add .dockerignore:** Create a `.dockerignore` file to exclude `node_modules`, `dist`, and other non-essential files from the build context.
4. **Build the Docker image:** Run `docker build -t my-angular-app:latest .`.
5. **Run the container:** Run `docker run -d -p 8080:80 my-angular-app:latest` to serve the app on port 8080.

### Validation

- Access `http://localhost:8080` in a browser. The Angular application should load.
- Inspect the container: verify it contains no dev files (`src/`, `node_modules`) and only the build output and Nginx.
- Check image size: it should be relatively small due to multi-stage build.


## Procedure: Set up CI pipeline with GitHub Actions

### When to use

When automating the build, test, and deployment process of the Angular application using GitHub Actions.

### Preconditions

- Repository hosted on GitHub.
- GitHub Actions enabled.


### Steps

1. **Create workflow file:** In `.github/workflows/`, create `ci.yml`.
2. **Define triggers:** Configure `on: [push, pull_request]` to run on commits.
3. **Job steps:** Add steps to the workflow:
    - **Checkout code:** Use `actions/checkout`.
    - **Setup Node:** Use `actions/setup-node@v*` with your Node version.
    - **Install dependencies:** `npm ci`.
    - **Run tests:** `npm test -- --watch=false` (ensure tests pass).
    - **Build app:** `npm run build -- --configuration production` to build for production.
    - **(Optional) Docker steps:** If deploying with Docker, add steps to build and push the Docker image (use your container registry credentials).
4. **Commit and push:** Save `ci.yml`, commit, and push. GitHub Actions will run on the next push.

### Validation

- In the GitHub repository’s **Actions** tab, confirm the workflow runs on push/PR.
- Each run should complete all steps: checkout, test, build. The build artifact should be created (or Docker image pushed) without errors.
