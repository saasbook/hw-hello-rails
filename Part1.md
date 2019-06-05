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

## Check your work: TBD
