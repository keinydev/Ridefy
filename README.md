# Ridefy
JSON RESTful API, for a small ride-hailing service build with Sinatra and PostgreSQL

## Api Documentation

[Apiary doc](https://ridefy.docs.apiary.io/)

## Previous configurations

- Create a .env file and add this variables

```
SINATRA_ENV=development
RACK_ENV=development
WOMPI_URL=test_url
WOMPI_PRIVATE_KEY=your_key
```

- Copy database.yml.example inside `config` folder and replace the data 

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
