## Url Shortner

This is a sinatra app with services to shorten and redirect urls.
It uses SecureRandom to generate url safe ids for the redirects.

Service       | method  | url                                 | params - JSON             | Output - JSON   Content-Type|Sucess Status| Error Status|
--------------|---------|-------------------------------------|---------------------------|-----------------------------|------|------|
Shortner      | POST    | http://hoshtname/shorten            | long_url, slug(OPTIONAL)  |long_url, shortened_slug     |201 | 500|
Redirect url  | GET     | http://hoshtname/shortened_slug     |                           |                             | 302 |404|


#### Steps to run the app:

* [unzip](https://github.com/andrewsheelan/url_shortner/archive/master.zip) , extract and run the following as an initial setup:

```
bundle install
bundle exec rake db:migrate
```

* To start the server:

```
bundle exec thin start
```

> default port - 3000

#### Steps to run the specs:

* Initial setup

```
bundle exec rake db:migrate RACK_ENV=test
```

* To run the tests

```
bundle exec rspec spec
```

#### Using the services:
###### USAGE: THE SHORTEN SERVICE

```
curl --data '{"long_url":"http://google.com"}' -X POST localhost:3000/shorten
```
> output: http://localhost:3000/UlVMnXBde88⏎

```
curl  -H "Accept: application/json" --data '{"long_url": "http://google.com", "slug":"google"}'  -X POST localhost:3000/shorten
```
> output: http://localhost:3000/google

###### USAGE: THE REDIRECT SERVICE
```
curl -X GET -L http://localhost:3000/NawcuuNLnfo
```

###### The root path also has a ui interface to allow using the service on the browser.

> Here's a deployed demo version of the code:

[Visit Demo!](https://immense-taiga-2935.herokuapp.com)
