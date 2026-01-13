# Dependency injection (general guidance)

- DI SHOULD be used for services, not as a store for runtime data; per-user/per-request dynamic data SHOULD NOT be modelled as container-registered singletons.
