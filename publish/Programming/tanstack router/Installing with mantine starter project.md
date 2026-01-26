
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


src/main.tsx

```
import { StrictMode } from 'react'

import ReactDOM from 'react-dom/client'

import { RouterProvider, createRouter } from '@tanstack/react-router'

import { TanStackRouterDevtoolsInProd } from '@tanstack/react-router-devtools'

import { TanStackRouterDevtools } from '@tanstack/react-router-devtools'

  

if(process.env.NODE_ENV === 'production'){

  <TanStackRouterDevtoolsInProd/>

}

  
  

// Import the generated route tree

import { routeTree } from './routeTree.gen'

  

// Create a new router instance

const router = createRouter({ routeTree })

  

// Register the router instance for type safety

declare module '@tanstack/react-router' {

  interface Register {

    Router: typeof router

  }

}

  

// Render the app

const rootElement = document.getElementById('root')!

if (!rootElement.innerHTML) {

  const root = ReactDOM.createRoot(rootElement)

  root.render(

    <StrictMode>

      <RouterProvider router={router} />

  

            <TanStackRouterDevtools />

    </StrictMode>,

  )

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

```
# Solution

```
 yarn add @types/node    
 
 
 if(process.env.NODE_ENV === 'production'){

  <TanStackRouterDevtoolsInProd/>

}
 
```



```



4 import { TanStackRouterDevtoolsInProd } from '@tanstack/react-router-devtools'
  

src/main.tsx:7:19 - error TS2304: Cannot find name 'createRootRoute'.


7 const rootRoute = createRootRoute({
                    ~~~~~~~~~~~~~~~

src/main.tsx:10:8 - error TS2304: Cannot find name 'Outlet'. 

10       <Outlet />

```


# Solution

```
imports for their names
```




```

src/routes/about.tsx:3:38 - error TS2345: Argument of type '"/about"' is not assignable to parameter of type 'undefined'. 

3 export const Route = createFileRoute('/about')({
                                       ~~~~~~~~

```

# Solution (generate routeTree.gen.ts)

```


follow the rest of the steps in here 

https://stackoverflow.com/questions/78830985/tanstack-react-router-argument-of-type-string-is-not-assignable-to-parameter

```


I have encountered the same problem. The issue is you missing routeTree.gen.ts file under src/. Although it should be auto generated, according to the docs it does not happen in some instances. The steps to solving this issue are:

- Download the tanstack router cli:
```
yarn add
@tanstack/router-cli

```
    
- Create tsr.config.json in your project root, example:
```

    `{       "$schema": "https://cdn.jsdelivr.net/npm/@tanstack/router-cli/schema.json",       "routesDirectory": "./src/routes",       "generatedRouteTree": "./src/routeTree.gen.ts",       "routeFileIgnorePattern": "\\.(test|spec)\\.[jt]sx?$"     }`
```
```
- Create a script in package.json and run it:

    `"scripts": {         "generate:routes": "tsr generate"       }`
```

This will create the required file according to your routes directory.



then do 

```
tsr generate
```





#tanstackRouter 