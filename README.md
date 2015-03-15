# Backend for simple Todo list application
## Install and run server
For install it and run server just type in your terminal:

    bundle install
    rake db:create dB:migrate
    rails server

## For testing
Just type commands in the terminal:

    bundle install
    rspec

## How it work
It was deploed to heroku.
Feel free to try it:
* Register new user (after this you must log in):

      curl -H "Content-Type: application/json" -d '{"email": "test@mail.net", "password": "12345678"}' https://still-journey-1279.herokuapp.com/api/v1/registrations

* Log in user:

      curl -H "Content-Type: application/json" -d '{"email": "test@mail.net", "password": "12345678"}' https://still-journey-1279.herokuapp.com/api/v1/sessions/log_in
This will create and give you new api_key.

* Log out:

      curl -H "Content-Type: application/json" https://still-journey-1279.herokuapp.com/api/v1/sessions/log_out?api_key=<given_api_key>
This will erase api key.

* Tasks for logged in user:

      curl -H "Content-Type: application/json" https://still-journey-1279.herokuapp.com/api/v1/tasks?api_key=<given_api_key>

* Create new task:

      curl -H "Content-Type: application/json" -d '{"time": "2014-01-10", "description": "new task", "status": "not started"}' https://still-journey-1279.herokuapp.com/api/v1/tasks?api_key=<given_api_key>

* Update existing task:

      curl -H "Content-Type: application/json" -X PUT -d '{"status": "started"}' https://still-journey-1279.herokuapp.com/api/v1/tasks/6?api_key=<given_api_key>

* Delete existing task:

      curl -H "Content-Type: application/json" -X DELETE https://still-journey-1279.herokuapp.com/api/v1/tasks/6?api_key=<given_api_key>
