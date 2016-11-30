# README

## Introduction
* Build the simple website that is similar to Twitter.
* In this project, I have learned about REST API, sending emails using Mailer (via Sendgrid), using Amazon S3 to store images, and implementing cool features which include use of local storage (cookies and sessions) etc.

* Ruby version : 5.0.0
## Go to this heroku website to check out

[Twitter Clone](desolate-plateau-53347.herokuapp.com)
[Testing](https://rails-pratice-stephen42.c9users.io)  #test app w/ cloudIDE


![Alt text](/demo.png?raw=true "from this project")


## To get started with the app
```
$ bundle install --without production
$ bundle exec guard init
```

## Installation
```
#Installing ImageMagick to resize the images before displaying.

#Cloud IDE
$ sudo apt-get update
$ sudo apt-get install imagemagick --fix-missing

#Local machine
$ brew install imagemagick
```

* Setting Up Amazon S3 for fog storage
```
$ heroku config:set S3_ACCESS_KEY=<access key>
$ heroku config:set S3_SECRET_KEY=<secret key>
$ heroku config:set S3_BUCKET=<bucket name>
$ heroku config:set S3_REGION=us-west-1
```

## Testing

```
$ rails test                  #check test/controllers/*
#advanced setup
$ bundle exec guard init       # will  monitors changes in the filesystem so that only those tests get run
                            #in order to avoid conflicts btw git and spring, just add spring/ directory in the .gitignore
                            # Ignore Spring files.
                            #/spring/*.pid

$ rails generate integration_test site_layout         #integration test for:
                                                    #Get the root path (Home page).
                                                    #Verify that the right page template is rendered.
                                                    #Check for the correct links to the Home, Help, About, and Contact pages.
$ rails generate integration_test users_signup
$ rails test:integration                              #Command to test just integration
@user = users(:michael)                             #test with users.yml to test against the user cases. Tested with user fixture. (test/fixtures/users.yml)
                                                    #check test/integration/users_login_test.rb
$ rails generate integration_test users_edit        #create an integration test for edit profile page

$ rails generate integration_test users_index       #test index page of users_controller
$ rails generate integration_test password_resets   #test invalid or valid submissions
$ rails generate integration_test users_profile     #generate an integration test for the profiles of our site’s users
$ rails generate integration_test microposts_interface
#integration test to log in, check the micropost pagination, 
#make an invalid submission, make a valid submission, delete a post, 
#and then visit a second user’s page to make sure there are no “delete” links.

$ rails generate migration add_reset_to_users reset_digest:string \
> reset_sent_at:datetime                            #modify the users data model and add reset_digest and reset_sent_at by generating migration

$ rails test test/models/micropost_test.rb \
>            --name test_order_should_be_most_recent_first      #test the most recent post should be the first.

# make sure to stop the server first if it is running.
$ rails db:migrate:reset #runs db:drop db:create db:migrate
$ rails db:seed

#reverse the boolean value in console
user.toggle!(:admin)
```

## Commands
* Generate && destroy elements
```
$ rails generate controller StaticPages home help
$ rails destroy  controller StaticPages home help
$ rails generate controller Sessions new #create controller for sessions
$ rails generate controller AccountActivations
$ rails generate controller PasswordResets new edit --no-test-framework                 #not including tests for controllers but instead build on top of existing tests                         #be still signed in.
$ rails generate controller Microposts
$ rails generate model User name:string email:string
$ rails destroy model User
$ rails generate mailer UserMailer account_activation password_reset        #mailer controller
$ rails generate model Micropost content:text user:references       #content is text type because string is limited to 255 characters
                                                                    #user is referenced to demonstrate belong_to relation
rails generate uploader Picture     #CarrierWave adds a Rails generator for creating an image uploader
``` 

* Rails server
```
$ rails server                                  # use if using local server
$ rails server -b $IP -p $PORT                  # Use `rails server` if running locally with Cloud IDE
$ rails server --environment production         # run the server based on environment
$ rails db:migrate RAILS_ENV=production         # create a production database for production environment
```

* Migrations change the state of the database using the command
```
$ rails db:migrate
$ rails db:migrate:reset                #to clear all the datbases
$ rails generate migration add_index_to_users_email         #create an index as user's email for user data
$ rails generate migration add_password_digest_to_users password_digest:string          #password_digest is hashed password. Need to be kept for authentication
$ rails generate migration add_remember_digest_to_users remember_digest:string          #remember_digest is basically create a cookie so that user can
$ rails generate controller PasswordResets new edit --no-test-framework                 #not including tests for controllers but instead build on top of existing tests                                                                             #be still signed in.
$ rails generate migration add_admin_to_users admin:boolean                             #add boolean admin column

$ rails generate migration add_activation_to_users \
> activation_digest:string activated:boolean activated_at:datetime              #this will add three attributes in the model

$ rails generate migration add_picture_to_microposts picture:string     #add picture attribute to the microposts
```

* We can undo a single migration step using
```
$ rails db:rollback
```

* To go all the way back to the beginning, we can use
```
  $ rails db:migrate VERSION=0
```

* Kill the spring processes if tests are running sluggishly
```
ps aux #see all the processes running in unix
ps aux | grep spring #see all processes named spring
kill -15 $(first 5 digit number)
spring stop
pkill -15 -f spring
```

* Asset directories
```
app/assets: assets specific to the present application
lib/assets: assets for libraries written by your dev team
vendor/assets: assets from third-party vendors
```

* Email Regex
```
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
Test with http://www.rubular.com/
```

* Puma
```
$ bundle exec puma -C config/puma.rb
```

* Debug
```
debugger
```

* Git
```
$ git add .
$ git branch $(new branch)
$ git branch -d $(current branch)
$ git checkout master 	#switch to branch ‘master’
$ git checkout -b $(branch name) #create new branch and go to it.
$ git merge $(name)	#merge!
$ git branch -d $(name)	#delete the branch or clean up!
$ git branch -D $(name)	#delete the branceh though havent merged in the changes.
$ git reset --hard HEAD~1	#reset the master origin to one previous commit.
$ git diff $(branch) HEAD~#(number of commits before...)
$ git diff --staged #one that has been added.
$ git push -u origin $(topic or branch name)
```

* Console
```
rails console --sandbox #too laggy somehow
```

* Emails with Heroku
```
$ heroku addons:create sendgrid:starter
$ heroku config:get SENDGRID_USERNAME
$ heroku config:get SENDGRID_PASSWORD
```

* Git Ignore
```
# Ignore bundler config.
/.bundle

# Ignore the default SQLite database.
/db/*.sqlite3
/db/*.sqlite3-journal

# Ignore all logfiles and tempfiles.
/log/*
/tmp/*
!/log/.keep
!/tmp/.keep

# Ignore Byebug command history file.
.byebug_history

## Ignore Spring files.
/spring/*.pid

# Ignore uploaded test images.
/public/uploads

```

## Security
```
#SSL in production to encrypt all relevant information before it leaves the local browser

# Force all access to the app over SSL, use Strict-Transport-Security,
  # and use secure cookies. In production.rb.
  config.force_ssl = true

```

## Problems 
```
error:Updates were rejected because the tip of your current branch is behind
$ git fetch
$ git pull origin master
$ git push -u origin master
```

## Deploy
```
$ heroku maintenance:on
$ git push heroku
$ heroku run rails db:migrate
$ heroku maintenance:off

$ heroku pg:reset DATABASE      #reset database
$ heroku run rails db:seed
$ heroku restart

```

## Authors
[Stephen Lee](http://www.stephenslee.xyz) -the hacker that dreams big.

## License
This project is free to all. Use this. Build things that matter.
