# Docker tips:

- docker container ls --all - List all containers (even inactive)
    
- docker logs --tail 100 [container ID] - See the logs for a container
    
- docker exec -it postgres-db (enter action after) - Interact with a container
    
- docker port postgres-db - see the port 
    
- src=. - The full stop is pointing to C:/Users/migue/ by default, however, if you want to define your path, you need to do src=C:/Users/Migue/Documents/Documents/community_dev/docker
    
-   
    

  

# Connecting to server through docker

Solution -

Journey:

 sslmode=verify-full sslrootcert=C:\Users\Migue\Documents\community_dev\Development\supabase\prod-ca-2021.crt

- docker run --name postgres-db -e POSTGRES_PASSWORD=dogsarecool -e POSTGRES_USER=miguel sslmode=verify-full sslrootcert=C:\Users\Migue\Documents\community_dev\Development\supabase\prod-ca-2021.crt
    
-  -e POSTGRES_DB=mydatabase -v postgres-data:/var/lib/postgresql/data -p 5433:5433   -d postgres:17
    

[https://stackoverflow.com/questions/55072221/deploying-postgresql-docker-with-ssl-certificate-and-key-with-volumes](https://stackoverflow.com/questions/55072221/deploying-postgresql-docker-with-ssl-certificate-and-key-with-volumes)

- Currently: looking at docker, I need a key and cert apparently to connect, but will look into this later
    
- If you are working from a Windows host, you will have a hard time with this. Because the permissions on any file in the volume that you map into the container will be -rwxr-xr-x (755), and the owner will be root. And you will not be able to change this as long as the file is mounted from your windows volumes. If you try using chmod on the file, it will just fail silently.
    
- [https://stackoverflow.com/questions/55072221/deploying-postgresql-docker-with-ssl-certificate-and-key-with-volumes](https://stackoverflow.com/questions/55072221/deploying-postgresql-docker-with-ssl-certificate-and-key-with-volumes)
    
- So apparently there seems to be a way through chmod 60 something 
    
- I realized now that for the connection to work, I need to allow anonymous connections in authentication, sign in providers, allow anonymous sign in
    

  

# unknown shorthand flag: 'â' in -–name

Solution - copying text from google sheets, check the hyphens

https://forum.restic.net/t/solved-unknown-shorthand-flag-a-in-exclude/6662

  

# Docker Requires at least 1 argument

Solution - need to define a image, otherwise it won’t work

https://stackoverflow.com/questions/56308424/docker-container-run-requires-at-least-1-argument

  

# Docker mount

Solution - src=. - The full stop is pointing to C:/Users/migue/ by default, however, if you want to define your path, you need to do src=C:/Users/Migue/Documents/Documents/community_dev/docker

docker run --mount type=bind,src=C:/Users/Migue/Documents/community_dev/docker,dst=/root/data/projects/pokeTrade --name postgres-db-local -e POSTGRES_PASSWORD=dogsarecool -e POSTGRES_USER=miguel -e POSTGRES_DB=mydatabase -p 5434:5434 -d postgres:17

  

  

Unsure if it needs a volume, but we’ll see

-v postgres-data:/var/lib/postgresql/data

  
  

Journey:

- Docker run –rm -it -v $localpath:dockerpath containerName bash
    
- Unable to find image 'postgres-db:latest' locally
    
- docker: Error response from daemon: pull access denied for postgres-db, repository does not exist or may require 'docker login'
    
- [stackoverflow.com/questions/56512769/unable-to-find-docker-image-locally](http://stackoverflow.com/questions/56512769/unable-to-find-docker-image-locally)
    
- [https://www.youtube.com/watch?v=HDBainlRuqY](https://www.youtube.com/watch?v=HDBainlRuqY)
    
- [https://nickjanetakis.com/blog/docker-tip-66-fixing-error-response-from-daemon-invalid-mode](https://nickjanetakis.com/blog/docker-tip-66-fixing-error-response-from-daemon-invalid-mode)
    
- https://nickjanetakis.com/blog/behind-the-scenes-of-debugging-an-error-that-i-couldnt-google
    
- docker run -tid --name postgres-local-volume -v /Users/Migue/Document/GitHub/tcg-trader-mern/routeDataDump/filteredCsvs:/home  postgres:17 (this code works as is, but I need to add the other parameters to this container so that it has password, user, etc
    
- docker run --name postgres-db -e POSTGRES_PASSWORD=dogsarecool -e POSTGRES_USER=miguel -e POSTGRES_DB=mydatabase -v postgres-data:/var/lib/postgresql/data -p 5433:5433  -d postgres:17
    

  

- Docker run -tid –name postgres-db-local -e POSTGRES_PASSWORD=dogsarecool -e POSTGRES_USER=miguel -e POSTGRES_DB=mydatabase -p 5434:5434 -v /Users/Migue/Documents/community_dev/docker:/home  -d postgres:17
    
-   
    
-   
    
- # The above works, the mount appears in docker, but I can’t see the files
    
- # https://forums.docker.com/t/problem-mounting-files/144593 
    
- [https://www.youtube.com/watch?v=HDBainlRuqY](https://www.youtube.com/watch?v=HDBainlRuqY)
    
-   
    
- I was following the tutorial, and currently the code works, creates a volume and container, but you can’t see a mount in your pc or your files in the docker volume.
    
- More to explore
    
- 13:22
    
- [https://forums.docker.com/t/files-on-host-system-not-seen-in-bind-mount/138930/5](https://forums.docker.com/t/files-on-host-system-not-seen-in-bind-mount/138930/5)
    
-   
    

# Copy files to Docker:

docker cp 

docker cp foo.txt container_id:/foo.txt

  

C:\Users\Migue\Documents\GitHub\tcg-trader-mern\routeDataDumps\filteredCsvs\artistsTable.csv 3fa9d316b20b:/home/test/artistsTable.csv

[https://stackoverflow.com/questions/22907231/how-can-i-copy-files-from-a-host-to-a-docker-container](https://stackoverflow.com/questions/22907231/how-can-i-copy-files-from-a-host-to-a-docker-container)

[https://spacelift.io/blog/docker-cp](https://spacelift.io/blog/docker-cp)

[https://stackoverflow.com/questions/56319218/postgresql-can-copy-command-be-used-to-copy-columns-from-multiple-tables](https://stackoverflow.com/questions/56319218/postgresql-can-copy-command-be-used-to-copy-columns-from-multiple-tables)

  
  
  

# Use psql in docker

Solution:  docker exec -it postgres-db psql -U (userName) -d (mydatabaseName)

  

Journey:

docker run -e POSTGRES_PASSWORD=postgres -it postgres

 pg_ctl -D /var/lib/postgresql/data -l logfile start

initdb: hint: You can change this by editing pg_hba.conf or using the option -A, or --auth-local and --auth-host, the next time you run initdb.

[https://www.datacamp.com/tutorial/postgresql-docker?dc_referrer=https%3A%2F%2Fwww.google.com%2F](https://www.datacamp.com/tutorial/postgresql-docker?dc_referrer=https%3A%2F%2Fwww.google.com%2F)

  

# Images are static. Containers contain those static images temporarily.

When you run a container, it only keeps what’s on the image, it deletes anything new.

Volumes keep the data inside a container if it’s defined on it.

  

# Exit psql

Solution - Type \q and then press ENTER to quit psql.

UPDATE: 19-OCT-2018

As of PostgreSQL 11, the keywords "quit" and "exit" in the PostgreSQL command-line interface have been included to help make it easier to leave the command-line tool.

  

Journey - https://stackoverflow.com/questions/9463318/how-to-exit-from-postgresql-command-line-utility-psql

  

# Error : template parsing error: template: :1: unclosed action

Solution - 

- Write double quotes ON THE TERMINAL, DON’T COPY FROM ANYWHERE, WON’T WORK EVEN IT THEY’RE DOUBLE QUOTES.
    
- Example: if you write the code here, and copy into the terminal, won’t work unless you write double quotes there.
    
- In places like 
    
- docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' [CONTAINERNAME]
    
- Must use “” instead of ‘’
    

  

# Connect pgadmin to postgres docker

Solution:

Journey:

- https://medium.com/@marvinjungre/get-postgresql-and-pgadmin-4-up-and-running-with-docker-4a8d81048aea
    
- Click add new server
    
- docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' [CONTAINERNAME]
    
- docker inspect -f “{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}” pgadmin-container
    
-   
    

  

# Install Pgadmin docker

Solution - 

- https://medium.com/@marvinjungre/get-postgresql-and-pgadmin-4-up-and-running-with-docker-4a8d81048aea
    
- You must change the user and password, otherwise it wont work.
    
- docker run --name pgadmin-container -p 5050:80 -e PGADMIN_DEFAULT_EMAIL=user@domain.com -e PGADMIN_DEFAULT_PASSWORD=catsarecool -d dpage/pgadmin4
    
- Go to localhost:5050
    
- Login
    
-   
    
-   
    
-   
    

Journey:

[https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html](https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html)

Scroll to the bottom and it says how to install it

docker pull dpage/pgadmin4

docker run -p 80:80

    -e 'PGADMIN_DEFAULT_EMAIL=user@domain.com'

    -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret'

    -e 'PGADMIN_CONFIG_ENHANCED_COOKIE_PROTECTION=True'

    -e 'PGADMIN_CONFIG_LOGIN_BANNER="Authorised users only!"'

    -e 'PGADMIN_CONFIG_CONSOLE_LOG_LEVEL=10'

    -d dpage/pgadmin4

-   
    

  
  
  

# Unable to run psql inside a postgres container

Solution: 

Journey:[https://forums.docker.com/t/unable-to-run-psql-inside-a-postgres-container/90623](https://forums.docker.com/t/unable-to-run-psql-inside-a-postgres-container/90623)