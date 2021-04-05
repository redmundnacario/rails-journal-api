# Rails-Journal-API

created by: 

## Redmund Nacario

### Note: `Testing scripts were intentionally not included in this repo.`

---

# Important informations

* Ruby version
  
    `ruby 3.0.0p0 (2020-12-25 revision 95aff21468)`

    `Rails 6.1.3.1`

* Dependencies

    See Gemfile

* Configuration

    Set config/application.yml for environment variables.

    Set cors configuration in config/initializers/cors.rb

* Creation

    `rails new <api-project-name> -api —no-sprockets -d -postgresql`

* Database initialization

    Use the generated `database.yml` in config/.

    Run `rails db:create` to create database.

    Edit the migration files and run `rails db:migrate`.

    Run seeds.rb through `rails db:seed`.

* How to run the test suite
  
    `rails test`

* Deployment instructions

    Deployment in Heroku
