
## Solution

https://www.youtube.com/watch?v=PFprNGSFi_U

create a .github/workflows
create a ci.yml

paste 

``` 
name: ci

  

on: [pull_request]

  

jobs:

build:

runs-on: ubuntu-latest

  

steps :

- name: Checkout repository

  uses: actions/checkout@v2

  

- name: Use Node.js

  uses: actions/setup-node@v2

  with:

    node-version: '14'

  

- name: Install dependencies

  run: npm install

  

- name: TypeScript type checking

  run: npm run build:check
```


on package.json,

```
"build": "vite build",

    "build:check": "tsc && vite build",
```

This means Netlify will read build without ts, meaning it won't have all those errors

https://stackoverflow.com/questions/62415804/how-to-prevent-netlify-from-treating-warnings-as-errors-because-process-env-ci

https://docs.netlify.com/build/configure-builds/troubleshooting-tips/#build-fails-on-warning-message

Go to environment variables in netlify
add variable

name CI
value - false

```
CI='' yarn run build

```