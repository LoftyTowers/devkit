# Package Management

## Scope

- When generated code relies on a library that may not already exist in the project, **add the required `<PackageReference>` entries**
  to the relevant `.csproj` file and **show the updated snippet** in the output.
- **Do not assume** a package already exists.
- **Do not replace this requirement with install commands** (e.g. `dotnet add package`).

## Rules

- None.

## Prohibited patterns

- None.

## Allowed deviations

- None.

## Cross-references

### Swagger package references

- Include `Swashbuckle.AspNetCore` as a `<PackageReference>` when generating Swagger-enabled APIs and show the `.csproj` snippet.
