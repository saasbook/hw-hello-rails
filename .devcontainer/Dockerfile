# Docker image for CHIP 4.8 (Hello, Rails!).
#
# Builds an environment with the Ruby, Rails, and Bundler versions the
# assignment's Part 1 asks you to verify. GitHub Codespaces and the VS Code
# Dev Containers extension build this same file, via
# .devcontainer/devcontainer.json -- there is no separate dev image.
#
# Unlike other chips, this image lives under .devcontainer/ rather than at the
# repo root, for two reasons specific to this assignment:
#
#   1. Part 1 has you wipe the repo with `rm -rf ./*` before creating the app.
#      That glob spares dotfiles, so a Dockerfile under .devcontainer/ survives
#      and the container can still be rebuilt afterwards.
#   2. `rails new` generates its own production `Dockerfile` at the repo root.
#      Keeping the dev image out of the root leaves that file alone.
#
# The image deliberately installs no gems: the starter repo has no Gemfile
# until you run `rails new`, which writes one and bundles it for you.
FROM ruby:3.3.8

# Part 1 asks you to verify these exact versions. Rails is installed into the
# image rather than via a Gemfile because the repo starts out empty -- you need
# a `rails` executable before there is an app to bundle.
#
# The base image ships Bundler 2.5.22 as a default gem; installing 2.6.9
# alongside it makes 2.6.9 the version `bundle` resolves to.
RUN gem install bundler -v 2.6.9 --no-document \
    && gem install rails -v 7.1.5 --no-document

# Everything else the assignment needs -- git, a C toolchain for native gems,
# and the SQLite and PostgreSQL client libraries -- is already in ruby:3.3.8.

WORKDIR /app

# `rails server -b 0.0.0.0` serves on port 3000.
EXPOSE 3000

# Tip: run with `-v "$(pwd)":/app` so your local edits are visible inside the
# container without rebuilding the image.
CMD ["bash"]
