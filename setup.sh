#!/bin/sh
echo "Downgrading bundler"
<<<<<<< HEAD
gem uninstall -i /home/gitpod/.rvm/gems/ruby-2.6.3 bundler -x
gem install bundler --version '1.17.3'
echo "Installing rails"
gem install rails --version=4.2.10
