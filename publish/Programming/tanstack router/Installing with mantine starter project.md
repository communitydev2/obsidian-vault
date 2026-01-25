
Starter project in mantine

```
https://github.com/mantinedev/vite-min-template
```


https://tanstack.com/router/latest/docs/framework/react/quick-start



Installing on existing project

```

yarn add @tanstack/react-router

```

Set module declaration for autocomplete in app.tsx

```
// src/app.tsx
declare module '@tanstack/react-router' {
  interface Register {
    router: typeof router
  }
}
```










#tanstackRouter