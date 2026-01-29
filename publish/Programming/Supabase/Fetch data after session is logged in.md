https://stackoverflow.com/questions/79746968/app-not-fetching-any-data-from-supabase-only-after-the-session-expires-hours-la

https://www.jwt.io/

https://www.youtube.com/watch?v=v3Exg5YpJvE&list=PL5S4mPUpp4OvE6MLbO1xAMvKLKT1sFsHF&index=1 - he explains how jwt work

It's possible to see info from the user when you copy the session code into jwt.io and you get headers from your auth table

RESTED

You can see all of the methods to fetch in API Docs - select your account

Tried to sign in in Postman using

supabase url
jwt token from session as bearer token for auth
on headers, used publishable key

# got  "message": "No API key found in request",

https://github.com/orgs/supabase/discussions/16241

I tried publishable key as both auth and api key
I also used the jwt token as both audh and api key, same error

### Solution 

- You can see all of the methods to fetch in API Docs - select the table you want
- press bash instead of javascript so you can test your routes through postman
- GET 
- Ensure you have SELECT policy set
- on Headers, set 
	- apikey - publishable key
	- authorization - jwt session after you've signed in to your account
	- make sure apikey is written like that, otherwise it won't work
- 
