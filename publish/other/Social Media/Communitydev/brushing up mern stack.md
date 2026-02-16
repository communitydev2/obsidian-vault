# brushing up mern stack

## 12/2/25

### https://medium.com/@gabrieldrouin/node-js-2025-guide-how-to-setup-express-js-with-typescript-eslint-and-prettier-b342cd21c30d


### things to take note
- nodemon is no longer used after node 18, now its tsx watch
- dotenv package is no longer needed after node 20.6, now it's --env-file .env
- .env.example for another dev to know which files to add
- Vitest is better than Jest as it has native ESM and Typescript support, Jest is better for CommonJs projects, and older node.js projects (v20 and below)
- Helmet is used to set security headers by default
- use cors 
- add husky
  ```
  app.use(helmet());
  ```
  - cors 
```

var express = require('express')
var cors = require('cors')
var app = express()

// Adds headers: Access-Control-Allow-Origin: *
app.use(cors())
```





- node -v > .nvmrc
- nvm install  
- nvm use
- npm init -y
- on package.json , change type to module
- remove   "main": "index.js",

```

  npm i express  tsconfig-paths cors helmet morgan   
npm i prettier typescript tsx dotenv  husky lint-staged @tsconfig/node22   @types/node @types/express eslint  @eslint/js eslint-plugin-perfectionist vitest @vitest/coverage-v8 @vitest/eslint-plugin -D
  open command prompt (must be in command prompt)
  tsc --init
  
```


- create src folder
- create index.ts
- add
```
import express from "express";  
const app = express();  
const port = "3000";  
  
app.get("/", (req, res) => {  
  res.send("Hello World!");  
  console.log("Response sent");  
});  
  
app.listen(port, () => {  
  console.log(`Example app listening on port ${port}`);  
});
```
you must cd into src and run node server.js

```
{  
  "extends": "@tsconfig/node22/tsconfig.json",  
  "compilerOptions": {  
    "outDir": "./dist",  
    "rootDir": "./"  
  },  
  "include": ["**/*.ts"],  
  "exclude": ["dist"]  
}
```


npx tsc


if you run node server.js, make sure you see the directory, as it can be wrong. I had to put dist/src

to run a tsx file without compilation, we do

```
npx tsx src/index.ts
```


to test file without showing ts errors , do 

```
npx tsc --noEmit && npx tsx src/index.ts
```

to run ts files as if you're using nodemon, do

```
npx tsx --watch src/index.ts
```

package.json

```
  "scripts": {  
    "dev": "tsx --watch src/index.ts",  
    "start": "node dist/index.js",  
    "build": "tsc",  
    "type-check": "tsc --noEmit",  
    "lint": "eslint .",  
    "lint:fix": "eslint --fix .",  
    "format": "prettier --write .",  
    "format:check": "prettier --check .",  
    "test": "echo \"Error: no test specified\" && exit 1",  
  },
```

to create a prettier rc , do

```
echo '{}' > .prettierrc
echo 'dist' > .prettierignore
```

```
mkdir .vscode  
cd .vscode  
 echo '{

   "recommendations": [

     "dbaeumer.vscode-eslint",

     "esbenp.prettier-vscode",

     "ms-vscode.vscode-typescript-next"

   ]

 }' >  extensions.json
 
  echo '{

  "editor.defaultFormatter": "esbenp.prettier-vscode",

  "editor.formatOnSave": true

}' >  settings.json
 
 
```

```
src/  
├── middlewares/  
│   └── middlewares.ts  
└── subfolder/  
   └── subsubfolder/  
       └── app/  
           └── index.ts
```

on package.json do 

```
 "imports": {  
    "#*": "./src/*"  
  }
```

when using dotenv, there are a few changes:

```
"scripts": {  
    "dev": "tsx --watch --env-file .env src/index.ts",  
    "start": "node --env-file .env dist/index.js",  
  },
```


#### Vitest

create a vitest.config.ts

```
import { defineConfig } from "vitest/config";  
  
export default defineConfig({});
```

scripts
```
"scripts": {  
  "build": "tsc -p tsconfig.build.json",  
  "test": "vitest",  
  "test:run": "vitest --run",  
  "test:ui": "vitest --ui",  
  "coverage": "vitest run --coverage",  
}
```

```
mkdir -p src/__tests__  
mkdir -p src/utils
```

create a tsconfig.build.json

```
{

  "extends": "./tsconfig.json",

  "exclude": ["**/*.test.ts", "**/*.spec.ts"]

}
```

eslint.config.ts

```
  
import eslint from "@eslint/js";  
import tseslint from "typescript-eslint";  
import perfectionist from "eslint-plugin-perfectionist";  
import vitest from "@vitest/eslint-plugin";  
  
export default tseslint.config(  
  {  
    ignores: ["**/*.js"],  
  },  
  eslint.configs.recommended,  
  tseslint.configs.strictTypeChecked,  
  tseslint.configs.stylisticTypeChecked,  
  {  
    languageOptions: {  
      parserOptions: {  
        projectService: true,  
        tsconfigRootDir: import.meta.dirname,  
      },  
    },  
  },  
  perfectionist.configs["recommended-natural"],  
  {  
    files: ["**/*.test.ts", "**/*.spec.ts"],  
    plugins: {  
      vitest,  
    },  
    rules: {  
      ...vitest.configs.recommended.rules,  
      "@typescript-eslint/unbound-method": "off",  
    },  
  },  
);
```

### Husky

Tests files before commiting
```

npx husky init
```

```
npm run test:run  
npm run type-check  
npx lint-staged
```

in package.json

```
 "lint-staged": {  
    "*.{js,jsx,ts,tsx}": [  
      "eslint",  
      "prettier --check"  
    ],  
    "*.{json,yml,yaml,md}": [  
      "prettier --check"  
    ]  
  }
```


### Github actions
```
mkdir -p .github/workflows  
touch .github/workflows/ci.yml

```

inside ci.yml

```
name: CI  
  
on:  
  push:  
    branches:  
      - main  
  
jobs:  
  quality-checks:  
    runs-on: ubuntu-latest  
  
    steps:  
      - name: Checkout code  
        uses: actions/checkout@v4  
  
      - name: Setup Node.js  
        uses: actions/setup-node@v4  
        with:  
          node-version-file: ".nvmrc"  
          cache: "npm"  
  
      - name: Install dependencies  
        run: npm ci  
  
      - name: Run tests  
        run: npm run test:run  
  
      - name: Run TypeScript type checking  
        run: npm run type-check  
  
      - name: Run ESLint and fix  
        run: npm run lint:fix  
  
      - name: Format with Prettier  
        run: npm run format  
  
      - name: Check for remaining ESLint errors  
        run: npm run lint  
  
      - name: Check for remaining formatting issues  
        run: npm run format:check
```
https://medium.com/@itsdavidmandal/building-a-basic-crud-app-with-the-mern-stack-a-step-by-step-guide-6eb551fb1161


### MongoDB

- in mongodb compass
- create connection, paste connection from server
- to find password, go to database & network access, and click on database users
- create a userModel,
	- schema
		- each field can be unique or required

```
npm i mongoose
```

to return new data in mongodb, do 

```
const updateUser = await User.findByIdAndUpdate(id,req.body,{

                new:true

            });
```

### Error The requested module '../routes/userroutes.js' does not provide an export named 'userroutes'


https://stackoverflow.com/questions/79217365/syntaxerror-the-requested-module-routes-authroutes-js-does-not-provide-an-e

if you have 

```
module.exports = router;
```

to 

```
export default router;
```

### TypeError: Cannot destructure property 'username' of 'req.body' as it is undefined.

https://stackoverflow.com/questions/62455716/typeerror-cannot-destructure-property-userid-of-req-body-as-it-is-undefined

```
must hbe before defining your routes
app.use(express.json())
```