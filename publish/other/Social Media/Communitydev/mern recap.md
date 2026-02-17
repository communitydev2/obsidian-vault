
- create folder 
- cd
- npm init-y
- on package.json , change type to module
- use cors
- use express
- use helmet
- prod install express tsconfig-paths cors helmet morgan axios
- prettier, typescript, tsx, husky lint-staged @tsconfig/node22 vitest @vitest/coverage-v8
- tsc --init
- create src folder
- index.ts
- start file
- npx tsx --watch src/index.ts
- start node dist/index.js
- create prettier rc
- for dotenv, 
	- on dev in package.json --env-file .env
- mongo
	- install mongoose
	- write connection string in .env
	- create .env.local
	- add !.env.local to gitignore
	- https://mongoosejs.com/docs/
	- create express.Router() in separate file with routes using axios
- postgres
	- run docker with db , db name, password, port and version
	- exec -it postgres psql -U postgres
	- \l
	- CREATE DATABASE myapp;
	- npm install pg
	- DATABASE_URL=postgresql://postgres:Password12!@localhost:5432/myapp
	- https://node-postgres.com/features/connecting
	- import pkg from 'pg';
const { Pool } = pkg;

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

const result = await pool.query('SELECT NOW()');
console.log(result.rows);
- CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);
- https://node-postgres.com/features/pooling


on react
- create axios.crete 
- with base url
- and headers  {'ngrok-skip-browser-warning': "true"}
- lastly , create!