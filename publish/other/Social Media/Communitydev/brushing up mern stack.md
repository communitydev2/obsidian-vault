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

import express from 'express'
import cors from 'cors'
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

  npm i express  tsconfig-paths cors helmet morgan axios  
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
- to find password, go to database & network access, and click on database users
- create a userModel,
	- schema
		- each field can be unique or required

```
npm i mongoose
```

to return new data in mongoose, do 

```
 let results = await User.find();

    res.send(results).status(200);
```

to post data in mongoose, do :

```
   const {username,email,age}= req.body;

  

    try{

        const userAdded = await User.create({

            username:username,

            email:email,

            age:age

        })

  

    res.status(201).json(userAdded);

```


find specific id

```
await Kitten.find({ name: /^fluff/ });
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


# Frontend
```

export default axios.create({

    baseURL: 'http://localhost:5050',

    headers: {'ngrok-skip-browser-warning': "true"}

});


```

in app.tsx

```
import api from "./api/axiosConfig.tsx";
 const response = await api.get("/record");

      pokeCardStore.setPokemonCards(response.data)

      return response
```


# using axios

```




router.get('/fetch',async(req,res)=>{

    // const {id} = req.params;

    const response = await axios.get('https://api.tcgdex.net/v2/en/cards/');

    res.send(response.data).status(200);

});



```


# postgres

https://node-postgres.com/

```
npm install pg
```


## use pgadmin with docker

https://event-driven.io/en/automatically_connect_pgadmin_to_database/

create compose.yml

```yml
services:

    postgres:

        image: postgres:17

        container_name: postgres

        environment:

            - POSTGRES_MULTIPLE_DATABASES="postgres,blogs,auth"

            - POSTGRES_USER=postgres

            - POSTGRES_PASSWORD=Password12!

        ports:

            - "5432:5432"

        volumes:

            - ./docker/postgres:/docker-entrypoint-initdb.d

  
  

    pgadmin:

        container_name: pgadmin_container

        image: dpage/pgadmin4

        environment:

            - PGADMIN_DEFAULT_EMAIL=${PGADMIN_DEFAULT_EMAIL:-pgadmin4@pgadmin.org}

            - PGADMIN_DEFAULT_PASSWORD=${PGADMIN_DEFAULT_PASSWORD:-postgres}

            - PGADMIN_CONFIG_SERVER_MODE=False

            - PGADMIN_CONFIG_MASTER_PASSWORD_REQUIRED=False

        ports:

            - "${PGADMIN_PORT:-5050}:80"

        depends_on:

            - postgres

        user: root

        entrypoint: /bin/sh -c "chmod 600 /pgpass; /entrypoint.sh;"

        volumes:

            - ./docker/pgAdmin/pgpass:/pgpass

            - ./docker/pgAdmin/servers.json:/pgadmin4/servers.json
```

then 

```
docker-compose up
```

docker volumes folder in windows will be in 

```
`\\wsl$\docker-desktop\mnt\docker-desktop-disk\data\docker\volumes`
```

https://forums.docker.com/t/issue-with-mounting-servers-json-into-pgadmin-container/144925/2


This will create a container with a postgres as well

```
services:

  postgres:

    image: postgres:17

    container_name: postgres

    environment:

      POSTGRES_USER: postgres

      POSTGRES_PASSWORD: "Password12!"

      POSTGRES_DB: postgres

    ports:

      - "5432:5432"

    volumes:

      - ./docker/postgres:/docker-entrypoint-initdb.d

  

  pgadmin:

    container_name: pgadmin_container

    image: dpage/pgadmin4:8.1

    restart: always

    depends_on:

      - postgres

    environment:

      PGADMIN_DEFAULT_EMAIL: ${PGADMIN_DEFAULT_EMAIL:-pgadmin4@pgadmin.org}

      PGADMIN_DEFAULT_PASSWORD: ${PGADMIN_DEFAULT_PASSWORD:-postgres}

      PGADMIN_CONFIG_SERVER_MODE: "False"

      PGADMIN_CONFIG_MASTER_PASSWORD_REQUIRED: "False"

    ports:

      - "${PGADMIN_PORT:-5050}:80"

    configs:

      - source: servers.json

        target: /pgadmin4/servers.json

      - source: preferences.json

        target: /pgadmin4/preferences.json

  

configs:

  preferences.json:

    content: |

      {

        "preferences": {

          "misc:themes:theme": "dark",

          "browser:display:show_system_objects": true,

          "browser:display:confirm_on_refresh_close": false,

          "browser:display:show_user_defined_templates": true

        }

      }

  servers.json:

    content: |

      {

        "Servers": {

          "1": {

            "Group": "Servers",

            "Name": "Local Postgres",

            "Host": "postgres",

            "Port": 5432,

            "MaintenanceDB": "postgres",

            "Username": "postgres",

            "SSLMode": "prefer",

            "Comment": "Connects to postgres service in this compose file."

          }

        }

      }
```
