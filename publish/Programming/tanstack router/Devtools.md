https://tanstack.com/router/latest/docs/framework/react/devtools#using-devtools-in-production

The Devtools, if imported as TanStackRouterDevtools will not be shown in production. If you want to have devtools in an environment with process.env.NODE_ENV === 'production', use instead TanStackRouterDevtoolsInProd, which has all the same options:QQ

import { TanStackRouterDevtoolsInProd } from '@tanstack/react-router-devtools'


#tanstackRouter 