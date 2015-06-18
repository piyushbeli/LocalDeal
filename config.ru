# This file is used by Rack-based servers to start the application.

#Setup the bundler for fetching the gem directly from github.
require 'bundler'
Bundler.setup(:default, :ci)

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application

