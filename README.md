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

2. Set up a database to store the Rails models, by writing and
executing an initial migration describing the database's schema

3. Create a basic set of controller actions and views to
support the CRUD actions (create, read, update, delete) on a resource
in a Rails app, and specify HTTP routes that map to the controller actions

4. Run and interact with the app in your development environment,
including using the debugger to interactively track down bugs and
inspect application state, such as the parameters supplied to a
controller action

5. Deploy the app to the public cloud, in this case using Heroku's
Platform-as-a-Service (PaaS) facility

## Homework Parts

1. [Part 1: Set up to create a new app](Part1.md)

2. [Part 2: Create the database and initial migration](Part2.md)

3. [Part 3: Create CRUD routes, actions, and views for Movies](Part3.md)

4. [Part 4: Run the app and use the debugger](Part4.md)

5. [Part 5: Deploy to the cloud, including production database](Part5.md)

