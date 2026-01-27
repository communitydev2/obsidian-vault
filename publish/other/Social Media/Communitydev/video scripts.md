# What is docker build

  

# What is Containers in docker

  

# video 2 - What are Images in docker


Images are packages built by the developer that contain all the dependencies,  libraries, tools and files that the containers require to run your finished application.

Do you know the expression "But it works on my computer!"
  
With docker that problem is no longer existent, as you can ship an image of your project where everyone will be able to run it just like it's running on your computer.

To make an image in docker

#current

https://www.youtube.com/watch?v=SnSH8Ht3MIc - 8:58

- Create a Dockerfile in your repo

```
FROM nginx:1.28.1-alpine

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
docker build -t tagname 
```

to delete an image, do 

```
docker rmi containerid
```

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