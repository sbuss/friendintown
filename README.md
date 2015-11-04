**ABANDONWARE  - this was for a YC application, and we abandoned it.**


= Getting your environment running

if you haven't created a gemset for development yet, then:

    rvm --create use 1.9.2@tourious-dev

else

    rvm use 1.9.2@tourious-dev

Once you're in the right ruby environment, you need to install rails, if you haven't already done so:

    gem install rails --version 3.0.9

Now you're ready to start developing.

First, install the project's dependencies:
 
    bundle install --binstubs

Then set up the database

    bundle exec rake db:migrate
    bundle exec rake db:test:prepare
    bundle exec rake db:populate

Now, in a free terminal (make sure this new terminal instance is in the right ruby environment -- see above)

    bin/spork

And, in another terminal:

    bin/autotest

If the tests pass, then you're done!


= Deploying on Heroku =
Do this with git. First, consider creating a tag.

    git tag -a v0.1 -m "Tag message"

Then push to heroku and migrate

    git push heroku master
    heroku rake db:migrate
