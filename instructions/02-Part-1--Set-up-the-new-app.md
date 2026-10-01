# Part 1: Set up the new app

## Choose a development environment

This assignment needs Ruby, Rails, and Bundler. You have four ways to get
them, and they all end up in the same place -- a shell in which the `rails`
command works:

| Method | Choose it if... |
|--------|-----------------|
| **Codio** | Your course uses Codio -- everything is preinstalled for you |
| **GitHub Codespaces** | You want a zero-install environment in the browser, hosted by GitHub |
| **Docker** | You want a ready-made, consistent environment on your own machine |
| **Local development** | You are comfortable installing Ruby and Rails yourself |

Codio and local development are ready to use as soon as you have a terminal. The
Codespaces and Docker options instead build a container from the
`.devcontainer` directory that ships in your team's repository, which pins the
exact Ruby, Rails, and Bundler versions this assignment expects -- so set one
of those up **after** you clone the repository in the next section:

* **GitHub Codespaces:** on your repo's GitHub page, click the green **Code**
  button, choose the **Codespaces** tab, and click **Create codespace on
  main**. The first launch takes a couple of minutes while the image builds.
  When the editor opens, use **Terminal -> New Terminal** to run the commands
  below. (You can also open the same codespace in your locally installed VS
  Code via the [GitHub Codespaces extension](https://marketplace.visualstudio.com/items?itemName=GitHub.codespaces).)

* **Docker:** install [Docker Desktop](https://www.docker.com/products/docker-desktop/),
  then from the root of your clone build the image and start a container,
  mounting your clone into it so edits you make on your machine are visible
  inside the container:

  ```sh
  cd rottenpotatoes
  docker build -f .devcontainer/Dockerfile -t chip-4.8 .
  docker run -it -p 3000:3000 -v "$(pwd)":/app --name chip-4.8 chip-4.8
  ```

  That drops you into a shell inside the container; run the assignment's
  commands there. To open a second shell into the *same* container (for
  example, one for the server and one for other commands), run
  `docker exec -it chip-4.8 bash`.

  The same VS Code "Dev Containers" extension that powers Codespaces can build
  this container for you locally -- **Dev Containers: Reopen in Container**.

## Verify you have correct versions of Ruby and Rails installed

(If you're using Codespaces or Docker, the container already pins all three
versions -- run steps 1-3 to confirm, and skip step 4. On Codio, run steps 3
and 4 only.)

1. Run `ruby -v` to check your Ruby version is >= 3.3.
2. Run `rails -v` to check your Rails version is 7.1.5. The assignment has not been tested with other versions, and there are files that will almost certainly cause errors with Rails >=8.*.*
3. Run `bundle -v` to **check your Bundler version is ~> 2.6.9**. 
4. If you now have more than one version of bundler installed, run `gem uninstall bundler`. A prompt will ask which version you'd like to uninstall. Enter the number associated with bundler-2.1.4 (likely `2`). Another prompt will appear asking to remove the bundler executable, enter `Y`.

## Clone the git repository that has been created for your team

First, run a `git clone` command. The repository `cs169/fa26-team-N-chip-4.8.git` has been created for your team already. You should replace `N` with your team number. The final argument of this git clone command (`rottenpotatoes`) is the name of the folder that Git will create to house the repository contents. This command will require that you be authenticated with Git, as was required in CHIPS 3.7.

```sh
git clone git@github.com:cs169/fa26-team-N-chip-4.8.git rottenpotatoes
cd rottenpotatoes
```

> **Note:** The name of the repository created for your team may differ.

Then, check out a branch for you or your pair. If you're completing CHIPS 4.8 individually, replace `<YOUR_BRANCH_NAME>` with your GitHub username (ex: `ethangnibus`). Pairs replace `<YOUR_BRANCH_NAME>` with the github usernames of the members of the pair separated by an underscore (ex: `ethangnibus_simonjov`). 

```sh
git checkout -b <YOUR_BRANCH_NAME>
```

Your Git repository came with a README. If another team member has already started CHIPS 4.8, they may have pushed to the `main` branch of your shared repository already. Either way, for CHIPS 4.8, you should remove every file in the repository so you can practice creating a Rails app for yourself. Keep in mind that the following command should be run **inside** the `rottenpotatoes` directory that was created:

```sh
rm -rf ./*
```

This command will remove most files in the directory, but will spare hidden files (any file whose name starts with a `.` character). That way, your `.git` folder is safe, and your repository will still function. The `.devcontainer` directory is spared for the same reason, so the Codespaces and Docker environments described above keep working after this step.

## Create a new Rails app

You may find the Rails [online documentation](https://api.rubyonrails.org/v7.1.5/) useful during this assignment.

Now that you have Ruby and Rails installed and your Git repository created, create a new, empty Rails app with the command:

```sh
rails new . --skip-test-unit --skip-turbolinks --skip-spring
```

The options tell Rails to omit three aspects of the new app:

* Rather than Ruby's `Test::Unit` framework, in a future assignment we will instead create tests using the RSpec framework.

* Turbolinks is a piece of trickery that uses AJAX behind-the-scenes to speed up page loads in your app.  However, it causes so many problems with JavaScript event bindings and scoping that we strongly recommend against using it.  A well tuned Rails app should not benefit much from the type of speedup Turbolinks provides.

* Spring is a gem that keeps your application "preloaded" making it faster to restart once stopped.  However, this sometimes causes unexpected effects when you make changes to your app, stop and restart, and the changes don't seem to take effect.  On modern hardware, the time saved by Spring is minimal, so we recommend against using it.

If you're interested, `rails new --help` shows more options available when creating a new app.


If all goes well, you'll see several messages about files being created, ending with run `bundle install`, which may take a couple of minutes to complete.  From now on, unless we say otherwise, **all file names and commands** will be relative to the app root.  Before going further, spend a few minutes examining the contents of the new app directory `rottenpotatoes` to remind yourself with some of the directories common to all Rails apps.

What about that message run `bundle install`?
Recall that Ruby libraries are packaged as "gems", and the tool `bundler` (itself a gem) tracks which versions of which libraries a particular app depends on. Open the file called `Gemfile` --it might surprise you that there are  already gem names in this file even though you haven't written any app code, but that's because Rails itself is a gem and also depends on several other gems, so the Rails app creation process creates a  default `Gemfile` for you.  For example,  you can see that `sqlite3` is listed, because the default Rails development environment expects to use the SQLite3 database.

OK, now ensure you're changed into the directory of the app you just created (`cd rottenpotatoes`) to continue...

## Specify Ruby version

It is a good practice to specify the Ruby version you are using in the `Gemfile`. Run `ruby -v` in the terminal to check the version you are using. In the `Gemfile`, add `ruby '<version>'` below `source 'https://rubygems.org'`. For example, on Codio or in the assignment's container you will see `ruby '3.3.8'`.

## Check your work

To make sure everything works, run the app locally.  (It doesn't do anything yet, but we can verify that it is running and reachable!)

The steps are a bit different depending on which development environment you chose. When you visit the app's home page, you should see the generic Ruby on Rails landing page, which is actually being served by your app.  Later we will define our own routes so that the "top level" page does not default to this banner.

First, one bit of setup that only Codio needs:

| Local computer, Docker, or Codespaces | Codio |
|-----|------|
| Nothing to do. | Allow external hosts to reach the app: open `config/environments/development.rb` and add `config.hosts.clear` anywhere inside the application's configurations. |

Start the app in a terminal:

| Local computer | Docker, Codespaces, or Codio |
|-----|------|
| `rails server` | `rails server -b 0.0.0.0` |

Then open the app's home page:

| Local computer | Docker, Codespaces, or Codio |
|-----|------|
| Open a regular browser window to `localhost:3000/` (note the `:3000` rather than `-3000`). | Your app is running inside a container or a remote machine, so you reach it through a forwarded port rather than directly. <br><br> **Docker:** you started the container with `-p 3000:3000`, so visit `localhost:3000/` in your own browser. <br><br> **Codespaces:** the port is forwarded for you as soon as the server starts, and a notification offers to open it. If you dismissed that notification, open the **Ports** panel, find port 3000, and click the globe icon. If port 3000 isn't listed at all, click **Forward a Port** and enter `3000`. <br><br> **Codio:** at the top of the Codio page, find the dropdown next to the button labeled either "Project Index (static)" or "Box URL". From the dropdown select "Box URL" and "New Browser Tab", then click the "Box URL" button itself (not the dropdown). |

## Why the difference?

The `-b 0.0.0.0` in the right-hand column matters whenever the app runs somewhere other than your own machine. By default the appserver only accepts connections from the machine it is running on, so a container or remote box would refuse the request your browser makes from outside it. `0.0.0.0` tells it to accept connections on every network interface.

Reaching the app differs for the same reason: inside a container or a Codio box, `localhost` refers to that machine rather than to yours. Docker and Codespaces bridge the gap with a forwarded port. Codio does it with [HTTP tunnelling](https://en.wikipedia.org/wiki/HTTP_tunnel) -- traffic sent to `https://`_subdomain_`-`_port_`.codio.io` is tunneled to port _port_ of the box running at _subdomain_, which is exactly the URL the "Box URL" button builds for you. Running directly on your own machine there is no boundary to cross, so the defaults are fine.

Git Walkthrough
----------------

Now it's time to push your changes to your team's shared repository on GitHub. First, create a commit with all of your changes, including the new Rails app you built. If another team member has already pushed to the `main` branch, you may find that this commit doesn't contain many changes. Note that when you created the app, Rails added a `.gitignore` file to prevent git from tracking unnecessary files.

```sh
git add --all .
git commit -m "Initial commit from <your name>"
```

After the commit is created, you can push your branch to the remote.

```sh
git push -u origin <YOUR_BRANCH_NAME>
```

As you continue to make changes to your repo, be sure to check to use `git branch` to make sure you are on your own branch before committing locally. Then, to push your changes to your remote branch simply run `git push origin`.

---

[← Hello Rails!](01-Hello-Rails-.md) | [Contents](README.md) | [Part 2: Create the database and initial migration →](03-Part-2--Create-the-database-and-initial-migration.md)
