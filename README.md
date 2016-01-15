To start the server, unzip and run
bundle install
thin start

default port - 3000

TO USE THE SHORTEN SERVICE
curl --data "long_url=http://google.com" -X POST localhost:4567/shorten

output: http://localhost:3000/NawcuuNLnfo

TO USE THE REDIRECT SERVICE
curl -X GET -L http://localhost:3000/NawcuuNLnfo


The root url also has a ui interface to allow using the service on the browser.

Here's a deployed version of the code:
https://immense-taiga-2935.herokuapp.com/
