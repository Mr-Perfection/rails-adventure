# README

This README would normally document whatever steps are necessary to get the
application up and running.

* Ruby version : 5.0.0


## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
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
$ rails destroy model User

```
Rails server
```
$ rails server -b $IP -p $PORT    # Use `rails server` if running locally.
```

Migrations change the state of the database using the command
```
$ rails db:migrate
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
rails test #check test/controllers/*
#advanced setup
bundle exec guard init # will  monitors changes in the filesystem so that only those tests get run
#in order to avoid conflicts btw git and spring, just add spring/ directory in the .gitignore
# Ignore Spring files.
#/spring/*.pid
```
Kill the spring processes if tests are running sluggishly

```
ps aux #see all the processes running in unix
ps aux | grep spring #see all processes named spring
kill -15 $(first 5 digit number)
spring stop
pkill -15 -f spring
```