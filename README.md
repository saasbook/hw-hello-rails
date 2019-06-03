# Hello Rails!

In previous assignments, you created and deployed a simple Hangperson
game using the Ruby-based Sinatra framework, and in the subsequent
assignment, you explored the differences between the Rails and Sinatra
versions of that same app.

In this assignment you will create your first Rails app from scratch:
a simple app called RottenPotatoes (inspired by the real web site
RottenTomatoes) for cataloging movies.

RottenPotatoes lets users interactively (via a Web browser) create
database entries for new movies, view or modify the content of movie
records (movie title, rating, description, and so on), and delete
movie records.  We provide some starter code you can copy and paste
into specific files, but you will do most of the work.  When the app
is running, you'll deploy it on the public cloud.

In later assignments, you'll add features to the app, such as the
ability to filter the list of movies, the ability to associate reviews
with movies, and per-user login so each user can maintain their own
ratings of movies.

## Learning Goals

After this assignment, you should know how to:

1. Create a new Rails app from scratch, including making necessary
adjustments to the `Gemfile` (specifying which libraries the app
relies on) and immediately placing the app under version control so
you can keep track of changes

2. Set up a database by writing and executing an initial migration describing the
database's schema

3. Create a basic set of routes, controller actions, and views to
support the CRUD actions (create, read, update, delete) on a resource
in a Rails app

4. Run and interact with the app in your development environment,
including using the debugger to interactively track down bugs

5. Deploy the app to the public cloud, in this case using Heroku's
Platform-as-a-Service (PaaS) facility

# Part 1: Set up the new app

Begin by logging into your development environment's home directory
and creating a new, empty
Rails app with the command `rails new rottenpotatoes -T`.

<blockquote>
`-T` tells Rails not to create a `test` directory, which would
normally contain tests writtng using
Ruby's `Test::Unit` framework.  In a future assignment we will instead
create
tests using the RSpec framework.
If you're interested, `rails new --help` shows more options available
when creating a new app.
</blockquote>


If all goes well, you'll see several messages about files being created,
ending with `run bundle install`.  You can now `cd` to the
newly-created `rottenpotatoes` directory, called the \x{app root}
directory for your new app.  From now on, unless we say otherwise, all
file names will be relative to the app root.  Before going further,
spend a few minutes examining the contents of the new app directory
`rottenpotatoes` to remind yourself with some of
the directories common to all Rails apps.

What about that message `run bundle install`?
Recall that Ruby libraries are packaged as "gems", and the tool
`bundler` (itself a gem) tracks which versions of which libraries a
particular app depends on.
Open the file called `Gemfile` --it might surprise you that there are 
already gem names in this file even though you haven't written any
app code, but that's because Rails itself is a gem and also depends on
several other gems, so the Rails app creation process creates a 
default `Gemfile` for you.  For example, 
you can see that `sqlite3` is listed, because the default
Rails development environment expects to use the SQLite3 database.

Edit your `Gemfile` by adding the following  (anywhere in the file, as long as
it's not inside a block beginning with `group`), to specify that we will use
the Haml
\index{HTML Abstraction Markup Language (Haml)!Rails app example}%
 templating system rather than the built-in `erb`.  
We explain this choice in Section \ref{sec:views}.

\codefile[e858c6b1ba260e9b0ecccdebd64cb2d7]{ch_rails/code/gemfile_edits.rb}

Once you've made this change to the `Gemfile`, 
run `bundle install -{`-without production}, which checks
if any gems specified in our `Gemfile` are missing and 
need to be installed.  Once done,
you should see ``Your bundle is complete'' as before.
Bundler creates the file `Gemfile.lock` listing which
versions of which Gems are \emph{actually being used} in your development
environment; 
  \index{Bundler!Gem versions}%
  \index{Gems!versions used}%
deployment platforms like Heroku use this information to
exactly match the gems and versions in your production environment.
  \index{Heroku!gem version matching}%
  \begin{sidebar}{Be sure}
  to place both `Gemfile` and `Gemfile.lock` under version control!
  Appendix \ref{sec:git} explains the basics if you haven't done
  this before.
  \end{sidebar}

Now we can explain the reason why we had to say `bundle exec
  rake routes` in Chapter \ref{chap:arch}, and why we will have to
prepend `bundle exec` to other `rake` tasks as well: just like your
app, these tasks may try to execute code that depends on having the
correct gems installed and available, and prefixing a command with
`bundle exec` runs that command in the context of the bundled gems.
  \index{Bundler!and Rake tasks}%
The Fallacies and Pitfalls at the end of this chapter gives a more
detailed explanation.

\automation
As the margin icon suggests, Bundler
\index{Automation for repeatability, Bundler}%
 is the first of many examples we'll
encounter of \emph{automation for repeatability:}
\index{Bundler!automation for repeatability}%
 rather than manually
installing the gems your app needs, listing them in the `Gemfile` and
letting Bundler install them automatically ensures that the task can be
repeated consistently in a variety of environments, eliminating mistakes
in doing such tasks as a possible source of app errors.  This is important
because when you deploy your app, the information is used to make the
deployment environment match your development environment.


# Part 2: Create the database and initial migration

# Part 3: Create CRUD routes, actions, and views for Movies

# Part 4: Run the app and use the debugger

# Part 5: Deploy to the cloud, including applying migrations in production

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
