# README

This README would normally document whatever steps are necessary to get the
application up and running.

* Ruby version : 5.0.0


## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```
Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
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
$ rails server -b $IP -p $PORT    # Use `rails server` if running locally.
 $ rails server --environment production        #run the server based on environment
 $ rails db:migrate RAILS_ENV=production        #create a production database for production environment
```

Migrations change the state of the database using the command
```
$ rails db:migrate
$ rails db:migrate:reset                #to clear all the datbases
$ rails generate migration add_index_to_users_email         #create an index as user's email for user data
$ rails generate migration add_password_digest_to_users password_digest:string          #password_digest is hashed password. Need to be kept for authentication
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