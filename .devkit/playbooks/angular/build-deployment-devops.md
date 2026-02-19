# Build deployment devops

## Context

Building and deploying an Angular application involves configuring the CLI for production optimizations, managing multiple environment settings, and automating the pipeline for consistency. Proper configuration ensures smaller bundle sizes, faster load times, and reliable deployments. Containerization and CI/CD integration further improve reproducibility and scalability of releases.

## Guidance

- Organise your Angular project with distinct build configurations (e.g. `development`, `staging`, `production`) and use Angular CLI’s environment file replacements for each.
- Prefer enabling Ahead-of-Time (AOT) compilation, tree-shaking, and all build optimizations in production builds (the CLI’s default production target already uses them).
- Use multi-stage Docker builds: compile the app in a Node container and then copy the output to a minimal Nginx (or similar) image for serving.
- Structure CI/CD pipelines to run lint, unit tests, and a production build on each commit or pull request. Then deploy the output (or Docker image) to the target environment.
- Consider using Angular’s new esbuild-based builder (`browser-esbuild` or `application`) for faster rebuilds and smaller bundles in Angular v18+ projects.
- Instrument your production build for monitoring: integrate Core Web Vitals metrics (e.g. LCP, CLS) and error tracking to capture user experience and runtime errors.


## Trade-offs

- **Optimization vs. Build Time:** Full production optimizations (minification, hashing, tree-shaking) slow down builds but greatly reduce bundle size and improve performance. Enable them in CI and production builds, and use fast builds for local development.
- **Container Overhead vs. Consistency:** Containerizing the app ensures environment consistency and easy scaling, but adds complexity to build and deployment. Multi-stage builds mitigate image size overhead.
- **Static Hosting vs. Server-Side Rendering:** Static hosting (CDNs, serverless) simplifies deployment for client-side apps, but SSR or server-based rendering adds SEO benefits at the cost of more complex deployment and runtime requirements.
- **Monitoring Overhead vs. Insight:** Adding analytics and error tracking (e.g. Google Analytics, Sentry) incurs slight performance and cost overhead, but provides crucial insight into production issues and user behavior.


## Decision criteria

- **Choose Static Hosting** when your app is purely client-side: use cloud storage or static web services (e.g. AWS S3/CloudFront, Azure Static Web Apps) to serve the `dist/` files. This is simple and highly scalable.
- **Choose Container Deployment** when you need a custom server or microservices integration: package the app into a Docker image and deploy to Kubernetes or container service for maximum control.
- **Use SSR/Prerendering** when SEO or initial load performance is critical. Otherwise, the standard SPA deployment is simpler.
- **Select Build vs. Develop Mode** based on target: use `ng build --configuration production` for releases (optimizations on), and `ng serve` or `ng build --watch` for development (faster feedback).


## Preferences

- PREFERENCE — JUSTIFIED: Define a dedicated `staging` build configuration to mirror production settings in testing environments.
- PREFERENCE — JUSTIFIED: Track Core Web Vitals in production to detect regressions in user experience.
- PREFERENCE — JUSTIFIED: Implement a global `ErrorHandler` to report uncaught exceptions to a monitoring service.
- PREFERENCE — JUSTIFIED: Use consistent commit hooks or CI checks to enforce coding and build standards before merging.
