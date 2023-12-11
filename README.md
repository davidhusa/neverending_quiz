# Quiz application README
This is a quiz game built in React with a Rails backend. Players can select answers until they find the correct one, upon which they'll be given a link to the next question until the end. Includes seed file with ten mind-bending riddles.

Currently hosted at https://bit.ly/reactquiz23

To run this application, you need to be running:
* Ruby 3.2.2
* Node.js v21.2.0
* Yarn 1.22.19
* Postgres 14.9

1) Install the gems with `bundle install`
2) Update the `username` and `password` fields under `default` in `config/database.yml` to credentials on your postgres db.
3) Run `rails db:create`
4) Run `rails db:migrate`
5) Run `rails db:seed`
6) Start the server with `bin/dev`
7) enjoy ;)
