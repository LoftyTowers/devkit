# Endpoint-level CORS with RequireCors

## Register a named policy
1) Add CORS services and define a named policy.
2) Keep the policy name consistent across endpoints.

```csharp
builder.Services.AddCors(options =>
{
    options.AddPolicy("PublicRead", policy =>
        policy.WithOrigins("https://example.com")
              .AllowAnyHeader()
              .AllowAnyMethod());
});
```

## Apply RequireCors to Minimal APIs
1) Map the endpoint.
2) Apply `RequireCors("PolicyName")` to the endpoint.

```csharp
app.MapGet("/status", () => Results.Ok())
   .RequireCors("PublicRead");
```

## When to prefer endpoint-level CORS
- Prefer endpoint-level CORS when only a subset of endpoints require a policy.
- Prefer global `UseCors` when a single policy applies to most endpoints.
