
## Solution:

## Create a trigger so that when the user authenticates the email, a new user_account is automatically created, with a foreign constraint.

![[Pasted image 20260202112817.png]]

## create user policies for all (update, insert , select)

![[Pasted image 20260202113114.png]]

## Setting routers in Postman

### Get router (gets public info from user)

- url - https://xxtbgyxfxcisfugzizys.supabase.co/rest/v1/user_account?select=*
- Headers
	- apikey - sb_publishable_UDCY3uXUW0HCWXpaHZPheQ_RwlhQsN4
	- Authorization - Bearer (copy jwt from sign in)

https://xxtbgyxfxcisfugzizys.supabase.co/rest/v1/user_account?select=*

### Post router 

- Won't work because the user has already been created, so you always have to PATCH

### Patch router 

- url - https://xxtbgyxfxcisfugzizys.supabase.co/rest/v1/user_account?user_id=eq.54f60b3a-a59e-40a2-806d-6bc22502ede0 (don't forget to change the user-id at the end of the url, which you can get from get auth router)
	- headers
		- apikey
		- authorization
		- Content-Type - application/json
		- prefer - return=representation
	- body
	```
	{

   "user_id": "54f60b3a-a59e-40a2-806d-6bc22502ede0",

    "username" : "tes566t"

}
	```
		


### get auth info

- url - https://xxtbgyxfxcisfugzizys.supabase.co/auth/v1/user
	- headers
		- apikey
		- Authorization
	- body
	```
	{

    "email":"miguelsalvadorstudios@gmail.com"

}
	```

Journey


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
- I'm supposed to get the whole table, need to search more
https://supabase.com/docs/guides/troubleshooting/why-is-my-select-returning-an-empty-data-array-and-i-have-data-in-the-table-xvOPgx

The issue is that I have UPDATE and INSERT policies, and they were clashing
Not having update wont allow me to change the username, meaning I have to make these two policies

# three default supabase functions

### auth.uid() 
auth.role()
auth.email()

## policy examples:
right(auth.email(),12) = '@supabase.io ' Ensures only emails with @supabase.io sign in

https://www.youtube.com/watch?v=Ow_Uzedfohk

auth.uid() = user_id
### update clause

https://neon.com/postgresql/postgresql-tutorial/postgresql-update


# Get tests

https://xxtbgyxfxcisfugzizys.supabase.co/auth/v1/user

## headers 

api key - publishable key
authroization

Result - 404

