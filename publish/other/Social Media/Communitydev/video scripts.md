
### how to make a screen display for the phone to computer

- donwload srcpy
- 🔗 Official download page:  
[https://developer.android.com/tools/releases/platform-tools](https://developer.android.com/tools/releases/platform-tools?utm_source=chatgpt.com)
- 4️⃣ Enable USB Debugging on Your Phone

On Android:

1. Settings → About Phone
    
2. Tap “Build number” 7 times
    
3. Go back → Developer Options
    
4. Enable **USB Debugging**
    

Plug phone into PC.

```
.\adb.exe devices -l 
you must see your phone there
```

full project structure

resources/
└── win/
    ├── adb/
    │   ├── adb.exe
    │   ├── AdbWinApi.dll
    │   └── AdbWinUsbApi.dll
    └── scrcpy/
        ├── scrcpy.exe
        ├── SDL2.dll
        ├── avcodec-*.dll
        └── ...

mkdir usb-mirror
cd usb-mirror
npm init -y
npm i electron
npm i -D electron-builder

mkdir usb-mirror
cd usb-mirror
npm init -y
npm i electron
npm i -D electron-builder

the files you need from src py and adb

Download from the official Android SDK Platform-Tools page (Google).

After extracting the zip, go into the `platform-tools` folder.

 ✅ Copy these files into:

resources/win/adb/

You need:

adb.exe  
AdbWinApi.dll  
AdbWinUsbApi.dll

That’s it.

❌ You do NOT need:

- fastboot.exe
    
- etc1tool.exe
    
- sqlite3.exe
    
- mke2fs.exe
    
- make_f2fs.exe
    
- NOTICE.txt
    

Those are unrelated to mirroring.

---

📦 2️⃣ scrcpy Folder

Download the Windows release zip from the official scrcpy GitHub.

When you extract it, you’ll see something like:

scrcpy.exe  
SDL2.dll  
avcodec-61.dll  
avformat-61.dll  
avutil-59.dll  
swresample-5.dll  
swscale-8.dll  
...

 ✅ Copy **everything from the scrcpy zip folder** into:

resources/win/scrcpy/

That means:

scrcpy.exe  
ALL .dll files

### how to make dynamic form

https://daily.dev/blog/reactjs-useform-for-dynamic-forms

register() takes info from any input or dropdowns
handleSubmit() handles press button
formState() keeps track of things whether the form's been changed
controller makes it easier to deal with external components

```
```jsx
<Controller
  name="firstName"
  control={control} 
  render={({ field }) => <TextField {...field} />}
/>
```

Move to steps to do the form







# how to make react typescript components

https://react.dev/learn/typescript


Interfaces are the best way to create components without having to define every type on the components

```
interface MyButtonProps {
  /** The text to display inside the button */
  title: string;
  /** Whether the button can be interacted with */
  disabled: boolean;
}

function MyButton({ title, disabled }: MyButtonProps) {
  return (
    <button disabled={disabled}>{title}</button>
  );
}

export default function MyApp() {
  return (
    <div>
      <h1>Welcome to my app</h1>
      <MyButton title="I'm a disabled button" disabled={true}/>
    </div>
  );
}
```



```
function MyButton({ title }: { title: string }) {
  return (
    <button>{title}</button>
  );
}

export default function MyApp() {
  return (
    <div>
      <h1>Welcome to my app</h1>
      <MyButton title="I'm a button" />
    </div>
  );
}

```
# Handling multiple account creation on react

- create a type of the input
- make a separate component for the input
- add a counter where everytime you press , it adds another field to add account.
- map according to the number you've input


# twitch intro

Hi all. If you want to see tools, websites, software that a community needs, you've come to the right place! I am creating a website for people to trade Pokemon cards in Pokemon Pocket at the moment. I'll see you live,

# What is docker build


# Manage cards menu

when I press the button Manage cards on header , it triggers a useState inside useStateStore named setShowManageCardsMainMenu
- display ManageCardsMainMenu
	- check if there's any tcg accounts, if not , display ManageTCGAccounts
	- 

# conditional rendering on header

```


  

            {authStore.session ? (

                        <Group visibleFrom="sm">

              <Text size="xl" c="dimmed">

                        Hi {authStore.user?.username}

                      <Button variant="default" onClick={handleManageCardsMenu}>Manage Cards</Button>

                      </Text>

          </Group>

            ) : (

              <Group visibleFrom="sm">

              <Button variant="default">Log in</Button>

              <Button>Sign up</Button>

          </Group>

  

            )}
```




## 11/2/26
- https://blog.risingstack.com/building-a-node-js-app-with-typescript-tutorial/
- create backend folder
- cd backend
```
tsc greeter.ts - this transpilates your file into javascript
```
- 
```
npm init -y inside folder  
  npm install express  tsconfig-paths dotenv typescript typescript-eslint-parser
npm install  ts-node nodemon @types/node @types/express -D
  open command prompt (must be in command prompt)
  tsc --init
  
```
https://tsconfig.guide/

add to package.json scripts

```
"tsc":"tsc"
```


App.ts:6:24 - error TS2349: This expression is not callable.
  Type 'typeof e' has no call signatures.

6         this.express = express()

solution:
https://stackoverflow.com/questions/53142239/typescript-express-type-typeof-e-has-no-compatible-call-signatures

```
javascript
import express from "express";
import bodyParser from "body-parser";
```
4 - Add ESLint






#### Cannot find name 'process'. Do you need to install type definitions for node? Try `npm i --save-dev @types/node`
- https://dev.to/asjadanis/parsing-env-with-typescript-3jjm
- create global.d.ts
```


namespace NodeJS {
  interface ProcessEnv {
    NODE_ENV: string;
    PORT: string;
    MONGO_URI: string;
  }
}


```
add to tsconfig.json

```
"typeRoots": ["./global.d.ts", "./node_modules/@types"]
```


- in the config.ts , add at the top
```
/// <reference types="node" />
```

#### Could not find a declaration file for module 'express'. 'c:/Users/Migue/Documents/GitHub/brushingupmern/backend/node_modules/express/index.js' implicitly has an 'any' type.
  Try `npm i --save-dev @types/express` if it exists or add a new declaration (.d.ts) file containing `declare module 'express';`


- https://stackoverflow.com/questions/75845719/could-not-find-a-declaration-file-for-module-express

#### error TS2307: Cannot find module 'dotenv' or its corresponding type declarations.

solution:

https://stackoverflow.com/questions/61407393/while-running-the-script-throws-cannot-find-module-dotenv

npm install dotenv

Read later

https://blog.risingstack.com/node-hero-node-js-project-structure-tutorial/


## 10/2/26

https://vtrsalgado.medium.com/a-simple-node-js-boilerplate-with-typescript-647c2601f04
```

npx create-nodejs-ts --no --app=new-app
--no doesn't print the inital prompt
```


create folder backend
cd backend

https://nodejs.org/en/learn/typescript/run#running-typescript-code-with-tsx

to use node with typescript, you need to :
```
npm i -D ts-node nodemon
npm add -D @types/node
npm i -D typescript # -D is a shorthand for --save-dev

npm install express  tsconfig-paths
```




they recommend type check your code first with `tsc` and then run it with `tsx` before shipping it.

when you do

```
npx tsx example.ts - converts ts to js 
npm install nodemon -D

```
change filename in package.json in "main"

error:

```
  at Function._resolveFilename (node:internal/modules/cjs/loader:1225:15)
    at Function._load (node:internal/modules/cjs/loader:1055:27)
    at TracingChannel.traceSync (node:diagnostics_channel:322:14)
    at wrapModuleLoad (node:internal/modules/cjs/loader:220:24)
    at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:170:5)     
    at node:internal/main/run_main_module:36:49 {
  code: 'MODULE_NOT_FOUND',
  requireStack: []
}
```


journey:
- installed express
- reinstalled everything
- npm install express  tsconfig-paths


https://nodejs.org/en/learn/getting-started/debugging



# video * - check if username already exists

##### Error: useEffect received a final argument during this render, but not during the previous render. Even though the final argument is optional, its type cannot change between renders.
https://www.dhiwise.com/post/understanding-the-importance-of-the-useeffect-dependency-array-in-react
##### error : useEffect not triggered through dependency array

-  journey
	- I think that pressing a button does not trigger a re render, and useEffects run on start of re render, meaning it doesn't re-trigger
	- I tried to run an empty dependency useEffect , didn't work
	- I tried setting  setPressSetUsernameButton(true); directly on the button's call state, that also didn't work
	- Passing an empty dependency array ([]) means the effect runs only on the initial render, and I thought It ran every cycle
	-```
	```
	() => {

          handleLogin(event)

        }}
        
	```
- 
	- If there's () =>  you need to add () to a function otherwise it won't trigger
- Update needs a where clause
- stored session on zustand


   const response = await supabase

        .from('user_account')

        .update({ username: username })

        .eq('user_id', authStore.user?.user_id)

        .select()


- authstore.user is empty
- issue was that user was set on account, which runs only after username is set, meaning you need to set user on usernameDialog if it's not set yet
- I've set user on username dialog on zustand
- I realized I'm storing user as an array, need to set it as object,
- I did 
- ```
  data[0] on the useEffect
  ```
  - to view the table info, go to table editor , select the table you want
  - I was setting user again on account , which is mounted after username is set, so it would glitch and go back to username
  - created two components, one to toggle the message, another to set the message
  - created a useEffect where I set it to false after 5 seconds
  - also had to create a check for empty usernames, as if you press send with a empty value, it will set to an empty value
## set up site URL

Authentication - URL Configuration
https://pokedexchange.netlify.app/

siteurl - http://localhost:5173/
redirect url - http://localhost:5173/auth/callback


# video 4 - netlify - set up project




# video 3 - What is supabase


#current


Supabase is a postgres development platform, with very good options for user authentication, replacement for a backend, automated router documentation, and the framework I'm currently using for the Pokemon Trading Website.

In order to submit data to the database, we need to access it using docker. It works to our next tutorial , where we will install all necessary containers to create tables and submit data to our online Postgres database.

Install postgres

```
docker pull postgres:17
```

```
docker run --mount type=bind,src=C:/Users/Migue/Documents/community_dev/docker,dst=/root/data/projects/pokeTrade --name postgres-db-local -e POSTGRES_PASSWORD=dogsarecool -e POSTGRES_USER=miguel -e POSTGRES_DB=mydatabase -p 5434:5434 -d postgres:17
```

```
$env:PGSSLMODE="require" docker exec -it postgres-db-local psql  -d postgres  -h host -p 5432  -U username
```
host is in 

connect button on top of supabase website

click on method

session pooler

view parameters

copy host and username

 if you know your database password, then grab it
otherwise go to database - settings - reset password, and store it somewhere safe 

\ - backlash

Error

```

At line:1 char:26
+ $env:PGSSLMODE="require" docker exec -it postgres-db-local psql ` -d  ...
+                    
Unexpected token 'docker' in expression or statement.
    + CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : UnexpectedToken

```
Solution - remove $env:PGSSLMODE="require" 

CREATE TABLE card (

card_idUUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
card_name text,
card_image,
card_local_id,

);
ALTER TABLE card ENABLE ROW LEVEL SECURITY;

make sure you have a cards.csv structured like this inside your directory

card_name,card_image,card_local_id
name1, image1,id1
name2,image2,id2

 \copy set ("official_card_count","total_card_count","set_code","set_name") FROM 'root/data/projects/pokeTrade' WITH (FORMAT CSV, NULL 'NULL', HEADER);

```








# video 2 - What are Images in docker


Images are packages built by the developer that contain all the dependencies,  libraries, tools and files that the containers require to run your finished application.

Do you know the expression "But it works on my computer!"
  
With docker that problem is no longer existent, as you can ship an image of your project where everyone will be able to run it just like it's running on your computer.

To make an image in docker

## [Sign in with your Docker account](https://docs.docker.com/get-started/introduction/build-and-push-first-image/#sign-in-with-your-docker-account)

To push images to Docker Hub, you will need to sign in with a Docker account.

1. Open the Docker Dashboard.
    
2. Select **Sign in** at the top-right corner.
    
3. If needed, create an account and then complete the sign-in flow.
    

Once you're done, you should see the **Sign in** button turn into a profile picture.

## [Create an image repository](https://docs.docker.com/get-started/introduction/build-and-push-first-image/#create-an-image-repository)

Now that you have an account, you can create an image repository. Just as a Git repository holds source code, an image repository stores container images.

1. Go to [Docker Hub](https://hub.docker.com).
    
2. Select **Create repository**.
    
3. On the **Create repository** page, enter the following information:
    
    - **Repository name** - `getting-started-todo-app`
    - **Short description** - feel free to enter a description if you'd like
    - **Visibility** - select **Public** to allow others to pull your customized to-do app


4. To get started, either clone or [download the project as a ZIP file](https://github.com/docker/getting-started-todo-app/archive/refs/heads/main.zip) to your local machine.
    
    ```console
     git clone https://github.com/docker/getting-started-todo-app
    ```
    
    And after the project is cloned, navigate into the new directory created by the clone:
    
    ```console
     cd getting-started-todo-app
    ```
    
5. Build the project by running the following command, swapping out `DOCKER_USERNAME` with your username.
    
    ```console
     docker build -t DOCKER_USERNAME/getting-started-todo-app .
    ```
    
    For example, if your Docker username was `mobydock`, you would run the following:
    
    ```console
     docker build -t mobydock/getting-started-todo-app .
    ```
    
6. To verify the image exists locally, you can use the `docker image ls` command:
    
    ```console
     docker image ls
    ```
    
    You will see output similar to the following:
    
    ```console
    REPOSITORY                          TAG       IMAGE ID       CREATED          SIZE
    mobydock/getting-started-todo-app   latest    1543656c9290   2 minutes ago    1.12GB
    ...
    ```
    
7. To push the image, use the `docker push` command. Be sure to replace `DOCKER_USERNAME` with your username:
    
    ```console
     docker push DOCKER_USERNAME/getting-started-todo-app
    ```
    
    Depending on your upload speeds, this may take a moment to push.

Now you're ready to create your containers in order to use this image.

you can now see it on you account , and the code for you to get into your other machines

docker push miguel454/getting-started-todo-app:tagname



```
docker ignore contents

node_modules

coverage

npm-debug.log

.DS_Store

yarn-error.log

.idea

.vscode

.yarn-cache

.yarn-cache/

.env
```
# following this tutorial

https://docs.docker.com/guides/nodejs/containerize/
```
git clone https://github.com/kristiyan-velkov/docker-nodejs-sample
```

# following this tutorial

https://docs.docker.com/get-started/introduction/develop-with-containers/

```
git clone https://github.com/docker/getting-started-todo-app
```

There are two types of images:

Docker Official images, which are for popular software

and Docker Hardened Images, with near zero common vulterabilities and exposures





https://www.youtube.com/watch?v=SnSH8Ht3MIc - 13:13

- Create a Dockerfile in your repo

```
// NGINX
FROM nginx:1.10.1-alpine

COPY project/index.html /usr/share/nginx/html

# CMD ["nginx","-g","daemon off;"]

```

```
// node
`# Use the latest LTS version of Node.js`

`FROM node:18-alpine`

`# Set the working directory inside the container`

`WORKDIR /app`

`# Copy package.json and package-lock.json`

`COPY package*.json ./`

`# Install dependencies`

`RUN npm install`

`# Copy the rest of your application files`

`COPY . .`

`# Expose the port your app runs on`

`EXPOSE 3000`

`# Define the command to run your app`

`CMD ["npm", "start"]`
```


run your repo in the terminal command by pressing the right click open in terminal or copy path , and paste in terminal

```
docker build . - currently doesn't work cause I had docker off
```

you can check with 

```
docker images
```

if you want to add a tag to your docker image do

```
docker build -t tagname .

```

to delete an image, do 

```
docker rmi imageid
```

```
docker run -d -p 80:80 imageID - builds container
```

```
docker ps - list all running containers
docker stop containerName
docker rm containerName
docker exec -it containerid /bin/sh - allows you to code inside the container in nginx
```

```
**/filename in dockerfile allows you to ignore path anywhere in file
```
# error  "/bin/sh -c npm install" did not complete successfully: exit code: 254



# What is Volumes in docker

  

# video 1 What is Docker

Docker allows you to share and ship applications between computers.

Do you have a bunch of dependencies, specific versions that make your application work?

Well worry not, as you can create an image of all those requirements, and ship it in an image.

  

Look at the logo. The whale is carrying containers right? Imagine each container is an instance of a built application, which you can run locally, whilst you can update the image at the same time, and ship new containers with the updates! You’ll only need to install one thing instead.

  

How do you use it, you say?

  
  

There are components of Docker, and those are, volumes, images and containers.

  

They all deserve their own video, so I’ll be splitting them into 3 different videos. 

  

Hope you follow for more information of… (back to top)

  

Say you have a finished product, and you have several requirements

  

There are three