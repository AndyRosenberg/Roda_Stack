# Roda Stack
Starter Pack with Roda/ActiveRecord/Vue/Bulma. User CRUD operations included.

## Setup
This version uses Ruby 2.5.7 and Node 13.8.0, run `bundle install` and `npm install` to set up dependencies. See `.env.example` for the environment variables you will need to set.

## How to run
This application is not hot-reloaded in development. `./local.sh` will build frontend assets and start the application up on an Agoo server.

#### Notes
[Sinatra-ActiveRecord](https://github.com/sinatra-activerecord/sinatra-activerecord) is used for database management, please refer to their docs for rake tasks. If you would like to add [Roda Plugins](https://roda.jeremyevans.net/documentation.html#plugins), feel free to do so in your version by adding them to `config/roda_ext.rb`.
