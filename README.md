# The Neverending Quiz Game
This is a quiz game built in React with a Rails backend and ChatGPT for generative content creation. Players can select answers until they find the correct one, upon which they'll be given a link to the next question until the end. Includes seed file with ten mind-bending riddles.

To run this application, you need to be running:
* Ruby 3.3.0
* Node.js v21.2.0
* Yarn 1.22.19
* Postgres 14.9
* An active OpenAI account with credits

1) Install the gems with `bundle install`
2) Install yarn packages with `yarn install`
3) Create a copy of the environment variable file with `cp .env.example .env`
4) Assign your desired postgres username and password to `PG_DATABASE_USERNAME` and `PG_DATABASE_PASSWORD` respectively, and your Open AI API key to `OPENAI_API_KEY` in `.env` file
5) Run `rails db:create`
6) Run `rails db:migrate`
7) Run `rails db:seed`
8) Start the server with `bin/dev`
9) enjoy ;)
