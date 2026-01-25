https://tanstack.com/router/latest/docs/framework/react/devtools#using-devtools-in-production

The Devtools, if imported as TanStackRouterDevtools will not be shown in production. If you want to have devtools in an environment with process.env.NODE_ENV === 'production', use instead TanStackRouterDevtoolsInProd, which has all the same options:

```
import { TanStackRouterDevtoolsInProd } from '@tanstack/react-router-devtools'
```

need to import this into the root

```
const rootRoute = createRootRoute({
  component: () => (
    <>
      <Outlet />
      <TanStackRouterDevtools />
    </>
  ),
})

const routeTree = rootRoute.addChildren([
  // ... other routes
])

const router = createRouter({
  routeTree,
})

function App() {
  return <RouterProvider router={router} />
}
```



#tanstackRouter 