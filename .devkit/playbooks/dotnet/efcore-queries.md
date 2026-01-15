# EF Core queries (guidance)

- Use tracking queries when updates are required or identity resolution is necessary; otherwise prefer no-tracking reads.
- `AsNoTrackingWithIdentityResolution` MAY be used when identity resolution is needed without full tracking.
- Project only required data (Select/DTO shaping) rather than materialising full entities unnecessarily.
- Choose loading strategy based on need:
  - Include for bounded related data needed immediately.
  - Explicit loading when the relationship is optional or conditional.
  - Projection when only a subset of fields is required.
- Avoid N+1 by ensuring related data is loaded explicitly or via projection.
