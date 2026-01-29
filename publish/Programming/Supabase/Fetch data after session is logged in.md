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

got  "message": "No API key found in request",

https://github.com/orgs/supabase/discussions/16241

