
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

src/routes/root

```
import { createRootRoute, Link, Outlet } from '@tanstack/react-router'
import { TanStackRouterDevtools } from '@tanstack/react-router-devtools'

const RootLayout = () => (
  <>
    <div className="p-2 flex gap-2">
      <Link to="/" className="[&.active]:font-bold">
        Home
      </Link>{' '}
      <Link to="/about" className="[&.active]:font-bold">
        About
      </Link>
    </div>
    <hr />
    <Outlet />
    <TanStackRouterDevtools />
  </>
)

export const Route = createRootRoute({ component: RootLayout })
```

src/routes/index

```
import { createFileRoute } from '@tanstack/react-router'

export const Route = createFileRoute('/')({
  component: Index,
})

function Index() {
  return (
    <div className="p-2">
      <h3>Welcome Home!</h3>
    </div>
  )
}
```


src/routes/about

```
import { createFileRoute } from '@tanstack/react-router'

export const Route = createFileRoute('/about')({
  component: About,
})

function About() {
  return <div className="p-2">Hello from About!</div>
}
```


I get the following errors in Netlify Build


```

src/App.tsx:9:20 - error TS2552: Cannot find name 'router'. Did you mean 'Router'?

9     router: typeof router

```
Solution 

```
import { Router } from "@tanstack/react-router";


declare module '@tanstack/react-router' {

  interface Register {

    router: typeof Router

  }

}

```





```               

src/main.tsx:3:8 - error TS2440: Import declaration conflicts with local declaration of 'App'.

3 import App from "./App.tsx";
         ~~~
```

Solution  - Delete this line


```

src/main.tsx:4:1 - error TS6133: 'TanStackRouterDevtoolsInProd' is declared but its value is never read.

4 import { TanStackRouterDevtoolsInProd } from '@tanstack/react-router-devtools'
  

src/main.tsx:7:19 - error TS2304: Cannot find name 'createRootRoute'.

7 const rootRoute = createRootRoute({
                    ~~~~~~~~~~~~~~~

src/main.tsx:10:8 - error TS2304: Cannot find name 'Outlet'. 

10       <Outlet />
          ~~~~~~

src/main.tsx:11:8 - error TS2552: Cannot find name 'TanStackRouterDevtools'. Did you mean 'TanStackRouterDevtoolsInProd'? 

11       <TanStackRouterDevtools />
          ~~~~~~~~~~~~~~~~~~~~~~

src/main.tsx:20:16 - error TS2304: Cannot find name 'createRouter'.

20 const router = createRouter({
                  ~~~~~~~~~~~~

src/main.tsx:25:11 - error TS2304: Cannot find name 'RouterProvider'.

25   return <RouterProvider router={router} />
             ~~~~~~~~~~~~~~

src/routes/about.tsx:3:38 - error TS2345: Argument of type '"/about"' is not assignable to parameter of type 'undefined'. 

3 export const Route = createFileRoute('/about')({
                                       ~~~~~~~~

src/routes/index.tsx:3:38 - error TS2345: Argument of type '"/"' is not assignable to parameter of type 'undefined'.      

3 export const Route = createFileRoute('/')({
                                       ~~~

src/routes/main.tsx:6:27 - error TS2307: Cannot find module './routeTree.gen' or its corresponding type declarations.     

6 import { routeTree } from './routeTree.gen'
                            ~~~~~~~~~~~~~~~~~

```


#tanstackRouter 