
# twitch intro

Hi all. If you want to see tools, websites, software that a community needs, you've come to the right place! I am creating a website for people to trade Pokemon cards in Pokemon Pocket at the moment. I'll see you live,

# What is docker build



# video * - authentication

https://www.youtube.com/watch?v=Q7P20fHJlm4


1:21:57


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

```
   const response = await supabase

        .from('user_account')

        .update({ username: username })

        .eq('user_id', authStore.user?.user_id)

        .select()
```

- authstore.user is empty
- issue was that user was set on account, which runs only after username is set, meaning you need to set user on usernameDialog if it's not set yet
- I've set user on username dialog on zustand
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
+                          ~~~~~~
Unexpected token 'docker' in expression or statement.
    + CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : UnexpectedToken
```

Solution - remove $env:PGSSLMODE="require" d

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