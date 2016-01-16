## Url Shortner

This is a sinatra app contains services to shorten(with an optional slug) and create redirect urls.

- The provided slug is made url safe and saved for redirects
- The optional Slugs are unique and does not allow duplicates
- It uses SecureRandom to generate url safe slugs, if a slug is not provided
- If an existing url is used and a slug is not provided, it reuses the existing non user slugged record

## The Shortner Services

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
###### USAGE: The Shortner Service

```
curl --data '{"long_url":"http://google.com"}' -X POST localhost:3000/shorten
```
> output: http://localhost:3000/UlVMnXBde88⏎

```
curl  -H "Accept: application/json" --data '{"long_url": "http://google.com", "slug":"google"}'  -X POST localhost:3000/shorten
```
> output: http://localhost:3000/google

###### USAGE: The Redirect Service
```
curl -X GET -L http://localhost:3000/NawcuuNLnfo
```

###### The root path also has a ui interface to allow using the service on the browser.

> Here's a deployed demo version of the code:

[Visit Demo!](https://urlshortnr.herokuapp.com)
