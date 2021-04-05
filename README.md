# Rails-Journal-API

created by: 

## Redmund Nacario

### Note: `Testing scripts were intentionally not included in this repository.`

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

    Deployment in Heroku:

    1. Create heroku app on its website.
   
    2. cd into Rails App folder from the root folder that is pushed to your repo

    3. `heroku git remote -a <app name in heroku>`

    4. `git push heroku master`

    5. Don’t forget to migrate your database to Heroku with `heroku run rake db:migrate`. Run this command while in Rails API project folder.

    6. If you have any environment variables set in your .env file that is added to git ignore file, set them up on Heroku by going to your applicatoin Dashboard -> Settings -> Config Variables.

    sources: 
    
    * https://medium.com/@nothingisfunny/deploying-rails-api-and-react-app-to-heroku-from-a-single-github-repo-7d8597abc55a

    * https://devcenter.heroku.com/articles/getting-started-with-rails6
