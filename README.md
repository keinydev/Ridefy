# Ridefy
JSON RESTful API, for a small ride-hailing service build with Sinatra and PostgreSQL

## Api Documentation

(Apiary doc)[https://ridefy.docs.apiary.io/]

## Install the gems needed

run
```
bundle install
```

## Run Database

Create a database

```
rake db:create
```

Create migrations

```
rake db:migrate
```

Load fake data

```
rake db:seed
```

## Run Test

Run tests

```
rspec spec
```

Run test with detailed format

```
rspec spec -f d
```

## Run App

Execute the console 

```
ruby app.rb
```
