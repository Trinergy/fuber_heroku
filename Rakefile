require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)
require_relative 'db/lib/order_importer.rb'
require_relative 'db/lib/user_importer.rb'
require_relative 'app/models/order.rb'
require_relative 'app/models/user.rb'

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  touch 'db/db.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/db.sqlite3'
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc 'populate the test database with data'
task 'db:setup_demo' => [:create, :migrate] do
  OrderImporter.new.import
  UserImporter.new.import
end
