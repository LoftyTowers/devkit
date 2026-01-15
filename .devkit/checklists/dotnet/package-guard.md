# Package Guard (dotnet)

- [ ] Do any files reference types from NuGet packages that are not listed in the target `.csproj`?
- [ ] If yes, add the correct `<PackageReference>` entries to that `.csproj` **and include the updated `.csproj` snippet in the output**.
- [ ] Confirm `Directory.Build.props` contains `<ImplicitUsings>enable</ImplicitUsings>`.
