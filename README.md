# README

This README would normally document whatever steps are necessary to get the
application up and running.

* Ruby version : 5.0.0


## Getting started

Go to this heroku website to check out
```
desolate-plateau-53347.herokuapp.com        #real app
https://rails-pratice-stephen42.c9users.io  #test app w/ cloudIDE
```
To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```
Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

Generate && destroy elements
```
$ rails generate controller StaticPages home help
$ rails destroy  controller StaticPages home help
$ rails generate model User name:string email:string
$ rails generate controller Sessions new #create controller for sessions
$ rails destroy model User

```
Rails server
```
$ rails server                                  # use if using local server
$ rails server -b $IP -p $PORT                  # Use `rails server` if running locally with Cloud IDE
$ rails server --environment production         # run the server based on environment
$ rails db:migrate RAILS_ENV=production         # create a production database for production environment
```

Migrations change the state of the database using the command
```
$ rails db:migrate
$ rails db:migrate:reset                #to clear all the datbases
$ rails generate migration add_index_to_users_email         #create an index as user's email for user data
$ rails generate migration add_password_digest_to_users password_digest:string          #password_digest is hashed password. Need to be kept for authentication
$ rails generate migration add_remember_digest_to_users remember_digest:string          #remember_digest is basically create a cookie so that user can
                                                                                        #be still signed in.
```
We can undo a single migration step using
```
$ rails db:rollback
```
To go all the way back to the beginning, we can use
```
  $ rails db:migrate VERSION=0
```

To run the test cases...
```
rails test                  #check test/controllers/*
#advanced setup
bundle exec guard init       # will  monitors changes in the filesystem so that only those tests get run
                            #in order to avoid conflicts btw git and spring, just add spring/ directory in the .gitignore
                            # Ignore Spring files.
                            #/spring/*.pid

rails generate integration_test site_layout         #integration test for:
                                                    #Get the root path (Home page).
                                                    #Verify that the right page template is rendered.
                                                    #Check for the correct links to the Home, Help, About, and Contact pages.
rails generate integration_test users_signup
rails test:integration                              #Command to test just integration
@user = users(:michael)                             #test with users.yml to test against the user cases. Tested with user fixture. (test/fixtures/users.yml)
                                                    #check test/integration/users_login_test.rb
$ rails generate integration_test users_edit        #create an integration test for edit profile page
``` 
Kill the spring processes if tests are running sluggishly

```
ps aux #see all the processes running in unix
ps aux | grep spring #see all processes named spring
kill -15 $(first 5 digit number)
spring stop
pkill -15 -f spring
```
Asset directories
```
app/assets: assets specific to the present application
lib/assets: assets for libraries written by your dev team
vendor/assets: assets from third-party vendors
```
Email Regex
```
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
Test with http://www.rubular.com/
```
Security
```
#SSL in production to encrypt all relevant information before it leaves the local browser

# Force all access to the app over SSL, use Strict-Transport-Security,
  # and use secure cookies. In production.rb.
  config.force_ssl = true

```

Puma
```
$ bundle exec puma -C config/puma.rb
```

Debug
```
debugger
```

Git
```
$ git add .
$ git branch $(new branch)
$ git branch -d $(current branch)
```

Deploy
```
$ heroku maintenance:on
$ git push heroku
$ heroku run rake db:migrate
$ heroku maintenance:off

```
