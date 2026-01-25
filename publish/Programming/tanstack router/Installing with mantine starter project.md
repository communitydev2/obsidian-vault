
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


Using File-Based Route Generation


```
yarn add @tanstack/react-router @tanstack/react-router-devtools
yarn add -D @tanstack/router-plugin
```

On vite,config.ts

```
// vite.config.ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { tanstackRouter } from '@tanstack/router-plugin/vite'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    // Please make sure that '@tanstack/router-plugin' is passed before '@vitejs/plugin-react'
    tanstackRouter({
      target: 'react',
      autoCodeSplitting: true,
    }),
    react(),
    // ...,
  ],
})
```

Create these files

```
- src/routes/__root.tsx (with two '_' characters)
- src/routes/index.tsx
- src/routes/about.tsx
- src/main.tsx
```





#tanstackRouter