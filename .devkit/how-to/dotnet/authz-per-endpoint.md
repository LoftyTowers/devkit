# Per-endpoint authorization policies

## Define named policies
1) Register authorization services.
2) Add named policies with clear intent.

```csharp
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("AdminOnly", policy => policy.RequireRole("Admin"));
});
```

## Minimal APIs
- Apply a named policy:

```csharp
app.MapPost("/admin/tasks", handler)
   .RequireAuthorization("AdminOnly");
```

- Use the default policy:

```csharp
app.MapGet("/profile", handler)
   .RequireAuthorization();
```

## MVC controllers
- Apply a named policy:

```csharp
[Authorize(Policy = "AdminOnly")]
public IActionResult GetAdminData() => Ok();
```

## When to prefer per-endpoint policies
- Use per-endpoint policies when different routes require different access rules.
- Use the fallback/default policy when most endpoints share the same access requirements.
