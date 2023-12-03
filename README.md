# README

To run this application, you need to be running:
Ruby 3.2.2
Node.js v21.2.0
Yarn 1.22.19
Postgres 14.9

1) Install the gems with `bundle install`
2) Update the `username` and `password` fields under `default` in `config/database.yml` to credentials on your local postgres db.
3) Run `rails db:create` and `rails db:migrate`
4) Start the server with `bin/dev`
5) enjoy ;)
