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

# Available API routes

| HTTP Request | Route | Description |
|----------|:-------------:|------:|
| GET | /api/user | Get users |
| GET | /api/user/:id | Get user by id |
| POST | /api/user/ | Create new user |
| PATCH | /api/user/:id | Update user by id |
| PUT | /api/user/:id | Update user by id |
| DELETE | /api/user/:id | Delete user by id |
| GET | /api/post | Get posts |
| GET | /api/post/:id | Get post by id |
| POST | /api/post/ | Create new post |
| PATCH | /api/post/:id | Update post by id |
| PUT | /api/post/:id | Update post by id |
| DELETE | /api/post/:id | Delete post by id |
| POST | /api/login | Authenticate user by <br />email and password, <br />generate temporary <br />access token |
| POST | /api/login/refresh | Refresh access token |
| POST | /api/login/delete | Delete access token |


Feel free to message me about suggestions and future improvements!

Made by [Lucas Cardoso](https://github.com/lucasncc)


