# Part 2: Create the database and initial migration


One problem ... databases and environments.

You wouldn't want to develop or test your app against the production
database, as bugs in your code might accidentally damage valuable
customer data.
So Rails defines three
\index{Environments, Rails basics}%
\emph{environments}---\T{production}, \T{development}, and
\T{test}---each of which manages its own separate database.

`config/database.yml`

The \T{test} database is entirely managed by the testing tools and
should never be modified manually: it is wiped clean and repopulated at
the beginning of every testing run, as we'll see in Chapter~\ref{chap:tdd}.

A brand-new Rails app has no database, so we need to create one.
The default \T{config\slash{}database.yml}, which we will use, specifies
that the development database will be stored
in the file \T{db\slash{}development.sqlite3}.
We could use the \T{sqlite3}
\weblink{http://www.sqlite.org/cli.html}{command-line tool} or a SQLite
GUI tool to create it manually, but how would we later
create the database and table in our production database when we deploy?  Typing the
same commands a second time isn't DRY,
\index{Don't Repeat Yourself (DRY)!Rails app example}%
and the exact commands might be
hard to remember.
Further, if the production database is something other than SQLite3
(as is almost certainly the case), the specific commands might be different.
And in the future, if we add more tables or make other changes to the
database, we'll face the same problem.

\automation 
A better alternative is a \x{migration}---a portable script for
changing the database schema (layout of tables and columns) in a consistent and
repeatable way,
\index{Migrations!Rails app example}%
just as Bundler uses the Gemfile to identify and install
necessary gems (libraries) in a consistent and repeatable way.
Changing the schema using migrations is a four-step process:

\codegen [0.2in]
\begin{enumerate}
\item Create a migration describing what changes to make.  
  As with
  \T{rails new}, Rails
  provides a migration \x{generator} that gives you the boilerplate code,
  plus various helper methods to describe the migration.
\item Apply the migration to the development database.  Rails defines a
  \T{rake} task for this.
\item Assuming the migration succeeded, update the test database's
  schema by running \T{rake db:test:prepare}.
\item Run your tests, and if all is well, apply the migration to the
  production database and deploy the new code to production.  The
  process for applying migrations in production 
  depends on the deployment environment; 
  Appendix~\ref{sec:Heroku} covers how to do it using Heroku, the
  cloud computing deployment environment used for the examples in this book.
\end{enumerate}

\learnbydoing[0.35in]
We'll use the first 3 steps of this process to add a new table that stores each
movie's title, rating, description, and release date, to match Chapter~\ref{chap:arch}.
Each migration needs
a name, and since this migration will create the movies table, we choose
the name CreateMovies.  
Run the command
\T{rails generate migration create\_movies},
\index{Generator, Rails app example}%
and if successful,
you will find a new file under \T{db/migrate} whose name begins
with the creation time and date and ends with the name
you supplied, for example, \T{20111201180638\-\_create\-\_movies.rb}.
(This naming scheme lets Rails apply migrations in the order they were
created, since the file names will sort in date order.)  Edit this file
to make it look like Figure~\ref{fig:initial_migration}.  As you can
see, migrations illustrate an idiomatic use of blocks: the
\C{ActiveRecord::Migration\#create\_table}
\index{ActiveRecord!Rails basics}%
 method takes a block of 1
argument and yields to that block
\index{Blocks!Rails basics}%
 an object representing the table being
created.  The methods \C{string}, \C{datetime}, and so on are provided
by this table object, and calling them results 
in creating columns in the newly-created database table; for example,
\C{t.string 'title'} creates a column  named \T{title} that can hold a
string, which for most databases means up to 255 characters.

\index{Migrations!Rails app example|textit}%
\codefilefigure[cd0bc6647751700aff9c166b88a7a871]{ch_rails/code/initial_migration.rb}{fig:initial_migration}{%
  A migration that creates a new Movies table, specifying the desired
  fields and their types.  The documentation for the \C{ActiveRecord::Migration} class (from
  which all migrations inherit) is part of the
  \protect\weblink{http://api.rubyonrails.org/v3.2.19/}{Rails documentation}, and gives
  more details and other migration options.}


Save the file and type \T{rake~db:migrate} to actually apply the
migration and create this table.  Note that this housekeeping task
also stores the migration number itself in the database, and
by default it only applies migrations that haven't already
been applied.  (Type \T{rake~db:migrate} again to verify that it
does nothing the second time.)

\begin{summary}
  \B{Summary}
  \begin{itemize}
  \item Rails defines three environments---development, production and
    test---each with its own copy of the database.
  \item A migration is a script describing a specific set of changes to
    the database.  As apps evolve and add features, migrations are added
    to express the database changes required to support those new features.
  \item Changing a database using a migration takes three steps: create
    the migration, 
    apply the migration to your development database, and (if
    applicable) after testing your code apply the migration to your
    production database.
  \item The \T{rails generate migration}
    generator fills in the boilerplate for a new
    migration, and the \C{ActiveRecord::Migration} class
    contains helpful methods for defining it.
  \item \T{rake db:migrate} applies  only
    those migrations not already applied to the development database.
    The method for applying migrations to a production database depends
    on the deployment environment.
  \end{itemize}
\end{summary}


As a last step before continuing, you should \x{seed} the database with some
movies to make the rest of the chapter more interesting, using the code
in Figure~\ref{fig:seeds}. Copy the code
 into \T{db\slash{}seeds.rb} and run \T{rake db:seed} to run it.


<details>
<summary>
  Do Rails models acquire the methods `where` and `find` via (a)
  inheritance or (b) mix-in?  (Hint: check the `movie.rb` file.)

</summary>
<blockquote>
</blockquote>
  (a) they inherit from `ActiveRecord::Base`.
</details>
