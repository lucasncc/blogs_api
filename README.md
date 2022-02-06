# BlogsApi

> API for Blogs made with Elixir and the Phoenix Framework

# Table of Contents

* [First Steps](#first-steps)
* [Available API routes](#available-api-routes)


# First Steps

**After installing [Elixir](https://elixir-lang.org/install.html), [Phoenix](https://hexdocs.pm/phoenix/installation.html) and a SQL database ([PostgeSQL](https://www.postgresql.org/download/) recommended), run the following commands:**

Clone the repository using:
```
git clone https://github.com/lucasncc/blogs_api
```

Enter the repository folder **blogs_api** via terminal, and execute the following commands:

Install dependencies with:
```
mix deps.get
```

Create database and run migration:
```
mix ecto.setup
```

Run the following command in order to start the API Server:
```
mix phx.server
```

Alternatively, API Server can also be started in tandem with the Elixir interpreter using the code:
```
iex -S mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser to access the API.

# Optional Steps

You can populate the database by running the following seed generating commands:
```
mix run priv/repo/seeds.exs
```

Run individual tests and documentation examples using the following command:
```
mix test
```

# Available API routes

All routes except "Create new user" and "Authenticate user" need a valid Bearer token authorization in the request's HTTP header.

"Delete user by id", "Update user by id" exist but are not routed, so users are only allowed to remove themselves by "Delete user by HTTP header token"

| HTTP Request | Route | Description |
|----------|:-------------:|------:|
| GET | /api/user | List users |
| GET | /api/user/:id | Get user by id |
| POST | /api/user/ | Create new user |
| DELETE | /api/user/:id | Delete user by id |
| DELETE | /api/user/me | Delete user by <br />HTTP header token |
| GET | /api/post | List posts |
| GET | /api/post/:id | Get post by id |
| GET | /api/post/search/:term | Get post containing term |
| POST | /api/post/ | Create new post |
| PATCH | /api/post/:id | Update post by id |
| PUT | /api/post/:id | Update post by id |
| DELETE | /api/post/:id | Delete post by id |
| POST | /api/login | Authenticate user by <br />email and password, <br />generate temporary <br />access token |
| POST | /api/login/refresh | Refresh access token |
| POST | /api/login/delete | Delete access token |

# Sample API requests

## User Requests

### Create new user

Send **POST** request to http://localhost:4000/api/user containing the following JSON body:
```
{
    "displayName": "Sergio Mendez",
    "email": "sergio@email.com",
    "password": "123456",
    "image": "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
}
```

### Authenticate user

Send **POST** request to http://localhost:4000/api/login containing the following JSON body:
```
{
    "email": "vivan.myers@example.com",
    "password": "platinum123"
}
```

### List users

Send **GET** request to http://localhost:4000/api/user containing a valid Bearer token in the header.

### List user by ID

Send **GET** request to http://localhost:4000/api/user/:id replacing :id with the user ID number. The request must have a valid Bearer token in the header.

### Delete User by active access Token (Delete_me)

Send **DELETE** request to http://localhost:4000/api/user/me containing a valid Bearer token in the header.

### Delete user by ID

Send **DELETE** request to http://localhost:4000/api/user/:id replacing :id with the user ID number. The request must have a valid Bearer token in the header.

## Post Requests

### Create new post

Send **POST** request to http://localhost:4000/api/post containing a valid Bearer token in the header and the following JSON body:
```
{
  "title": "Latest updates, August 1st",
  "content": "The whole text for the blog post goes here in this key"
}
``` 

### List posts

Send **GET** request to http://localhost:4000/api/posts.

### List post by ID

Send **GET** request to http://localhost:4000/api/posts/:id replacing :id with the post ID number.

### Update new post

Send **PUT** request to http://localhost:4000/api/post/:id containing a valid Bearer token in the header, replacing :id with the post ID number and the following JSON body:
```
{"post": 
    {
    "title": "Latest updates, August 5st",
    "content": "The whole text for the blog post goes here in this key"
    }
}
``` 

### Update new post

Send **GET** request to http://localhost:4000/api/post/search/:term containing a valid Bearer token in the header and replacing :term with the term to be searched in the posts contents.
```
{"post": 
    {
    "title": "Latest updates, August 5st",
    "content": "The whole text for the blog post goes here in this key"
    }
}
``` 

### Delete post by ID

Send **DELETE** request to http://localhost:4000/api/post/:id containing a valid Bearer token in the header and replacing :id with the id number of the post to be deleted.


Feel free to message me about suggestions and future improvements!

Made by [Lucas Cardoso](https://github.com/lucasncc)


