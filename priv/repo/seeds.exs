# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BlogsApi.Repo.insert!(%BlogsApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BlogsApi.Repo
alias BlogsApi.Blog
alias BlogsApi.Blog.User

%{
  "displayName": "Brett Wiltshire",
  "email": "brett@email.com",
  "password": "123456",
  "image": "http://4.bp.blogspot.com/_YA50adQ-7vQ/S1gfR_6ufpI/AAAAAAAAAAk/1ErJGgRWZDg/S45/brett.png"
}
|> Blog.create_user

%{
  "displayName": "Eli Schmidt",
  "email": "eli.schmidt@example.com",
  "password": "cold1234",
  "image": "https://randomuser.me/api/portraits/men/13.jpg"
}
|> Blog.create_user

%{
  "displayName": "Judy Robinson",
  "email": "judy.robinson@example.com",
  "password": "taylor213",
  "image": "https://randomuser.me/api/portraits/women/66.jpg"
}
|> Blog.create_user

%{
  "displayName": "Wilma Watkins",
  "email": "wilma.watkins@example.com",
  "password": "b00kw0rM",
  "image": "https://randomuser.me/api/portraits/women/47.jpg"
}
|> Blog.create_user

%{
  "displayName": "Jimmy Brown",
  "email": "jimmy.brown@example.com",
  "password": "jimbrown352",
  "image": "https://randomuser.me/api/portraits/men/4.jpg"
}
|> Blog.create_user
