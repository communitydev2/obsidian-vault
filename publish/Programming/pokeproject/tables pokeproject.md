# $env:PGSSLMODE="require" docker exec -it postgres-db-local psql ` -d postgres ` -h host` -p 5432 ` -U username 

  

# Process for inserting a new set:

- Run python file to obtain tables:
    

- Cards
    
- Illustrator (don’t add any duplicates)
    
- Set info (probs only 1 new table)
    
- Save info in docker host directory
    

- Docker restart container
    

- Since we’re mounting files in the container by using /Documents/community_dev/docker , we’re doing it differently
    
- We’re restarting the container so the new instance can have all the files
    
- docker restart postgres-db-local
    
- s
    

- Connect to postgres server
    

- docker exec -it (dockerContainerName) psql -d (remoteDBName) -h (hostName) -p (port) -U (username) 
    
- Copy only desired columns from file (name is the name of the illustrator)(must match column names exactly)
    
- \copy rarity ("name") FROM 'root/data/projects/pokeTrade/rarity.csv';
    
- \copy set ("official_card_count","total_card_count","set_code","set_name") FROM 'root/data/projects/pokeTrade
    
- /set.csv' WITH (delimiter ',', format csv,header);
    
-   
    

  

---

  

- This is what to do if you’re using volumes instead:
    
- Run docker to upload files:
    

- Docker exec -it postgres-db mkdir -p /home/pokeTrade/(newSetName)
    
- docker cp C:\Users\Migue\Documents\GitHub\tcg-trader-mern\routeDataDumps\filteredCsvs\artistsTable.csv 3fa9d316b20b:/home/pokeTrade/(newSetName)/artistsTable.csv
    

- Connect to postgres server
    

- docker exec -it (dockerContainerName) psql -d (remoteDBName) -h (hostName) -p (port) -U (username) 
    
- Copy only desired columns from file (name is the name of the illustrator)(must match column names exactly)
    
- \copy illustrator("name") FROM 'home/test/artistsTable.csv';
    
-   
    

  

---

  
  
  

# Create the tables for pokeTrade:

  

## Default

create table if not exists public.banned_words (

  word text primary key

);

  
  
  

Card

  

CREATE TABLE card (

card_idUUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,
card_name text);
ALTER TABLE card ENABLE ROW LEVEL SECURITY;
  
  

- Rarity table
    

CREATE TABLE rarity (

rarityID UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,

name VARCHAR(20) );

  

ALTER TABLE rarity ENABLE ROW LEVEL SECURITY;

  

- Set table
    

  

CREATE TABLE set (

set_id UUID DEFAULT uuid_generate_v4() UNIQUE NOT NULL,

official_card_count INT,

total_card_count INT,

set_code VARCHAR(4),

set_name VARCHAR(30)

);

ALTER TABLE set ENABLE ROW LEVEL SECURITY;

  

- Illustrator table
    

CREATE TABLE illustrator (

illustratorId UUID DEFAULT uuid_generate_v4()

UNIQUE NOT NULL,

name VARCHAR(30),

picture TEXT);

  

ALTER TABLE illustrator ENABLE ROW LEVEL SECURITY;

  
  

Friend table 

  

CREATE TABLE friend (

friend_id UUID DEFAULT uuid_generate_v4()

UNIQUE NOT NULL,

user_id uuid references player_account(user_id),

favorite boolean,

user_id_2 uuid references player_account(user_id)

);

  

ALTER TABLE friend ENABLE ROW LEVEL SECURITY;

  
  

CREATE TABLE player_account (

  user_id  UUID DEFAULT uuid_generate_v4()

UNIQUE NOT NULL,

  username varchar(30),

  password varchar(30),

  discord_id varchar(255),

  email varchar(255),

  email_updates boolean,

show_discord_id boolean

);

  

ALTER TABLE player_account ENABLE ROW LEVEL SECURITY;

  
  

Date

Uuid

  

# Data Types

[https://www.postgresql.org/docs/current/datatype.html](https://www.postgresql.org/docs/current/datatype.html)

  
  

# Constraints

[https://www.postgresql.org/docs/current/ddl-constraints.html](https://www.postgresql.org/docs/current/ddl-constraints.html)

  

CREATE TABLE 

  

# Primary keys

[https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-PRIMARY-KEYS](https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-PRIMARY-KEYS)

  

# Foreign Keys

[https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-FK](https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-FK)