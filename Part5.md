# Part 5: Deploy to the cloud, including the production database

In the Sinatra Hangperson assignment, you already learned how to
deploy a Sinatra app to Heroku.
Deploying a Rails app is very similar, but a few extra steps are
required since most Rails apps use databases.

Follow the instructions in [this Heroku
article](https://devcenter.heroku.com/articles/getting-started-with-rails5) 
to deploy your app.  Note in particular that because Heroku uses
PostgreSQL as the default database for production but Rails uses
SQLite3 as the default database for development and testing, not only
will you have to specify that your app depends on the `pg`
(PostgreSQL) gem when running on Heroku, but that it should **not**
attempt to use the SQLite3 gem when running on Heroku (since Heroku is
set up in such a way that the SQLite3 gem simply won't work).

The key to distinguishing these two scenarios is to remember that
Rails checks the environment variable `RAILS_ENV` to determine whether
it is running in production, development, or testing.  The testing
tools always arrange to set it to `test`, and Heroku by default
arranges to set it to `production`.  You must therefore specify in
`Gemfile` that the SQLite3 gem should only be used in development and
testing, and the PostgreSQL gem should only be used in production
(unless you want to also develop locally using PostgreSQL, which is
beyond the scope of this assignment).  

To do that, modify the `Gemfile` line about the SQLite3 gem, and add a
line regarding the PostgreSQL gem:

```ruby
gem 'sqlite3', group: [:development, :test]
gem 'pg', group: [:production]
```

You must then re-run `bundle install --without production`, and commit all
these changes back into Git.

At that point you can follow the instructions to "push" your
repository to Heroku for deployment.
Heroku will by default assign your app a randomly
chosen name, such as `heavenly-coconut-237`, so that your app would be
available at `http://heavenly-coconut-237.herokuapp.com`; but you can
change this to any unused name on Heroku.

Verify that your app works correctly on Heroku just as it does in your
development environment.

Voila -- you have created and deployed your first Rails app!


<details>
<summary>
What are the two steps you must take to have your app use a particular
Ruby gem? 
</summary>
<blockquote>
You must add a line to your `Gemfile` to add a gem and re-run `bundle install`.
</blockquote>
</details>
