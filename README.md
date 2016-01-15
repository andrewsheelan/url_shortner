## Url Shortner

This is a sinatra app with services to shorten and redirect urls.
It uses SecureRandom to generate url safe ids for the redirects.

Service       | method  | url                                 | params    | output      |
--------------|---------|-------------------------------------|-----------|-------------|
Shortner      | POST    | http://<hoshtname>/shorten          | long_url  |shortened id |
Redirect url  | GET     | http://<hoshtname>/<shortened id>   |           |redirect     |


#### Steps to run the app:

* To start the server, [unzip](https://github.com/andrewsheelan/url_shortner/archive/master.zip) , extract and run the following:

```
bundle install
bundle exec thin start
```

> default port - 3000

####### TO USE THE SHORTEN SERVICE

```
curl --data "long_url=http://google.com" -X POST localhost:4567/shorten
```
output: http://localhost:3000/NawcuuNLnfo

####### TO USE THE REDIRECT SERVICE
```
curl -X GET -L http://localhost:3000/NawcuuNLnfo
```

> The root path also has a ui interface to allow using the service on the browser.


* Here's a deployed demo version of the code:

[Visit Demo!](https://immense-taiga-2935.herokuapp.com)
