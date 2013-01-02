# encoding: utf-8

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "FXrate"
  gem.homepage = "http://github.com/jafrog/FXrate"
  gem.license = "MIT"
  gem.summary = %Q{TODO: one-line summary of your gem}
  gem.description = %Q{TODO: longer description of your gem}
  gem.email = "howeveririna@gmail.com"
  gem.authors = ["jafrog"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "FXrate #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace :db do
  namespace :sqlite do
    require File.join(File.dirname(__FILE__), 'lib/storages/sqlite_storage')
    desc 'create sqlite db and tables'
    task :migrate, :db_name do |t, args|
      args.with_defaults :db_name => 'fxrate.db'
      db = SQLite3::Database.new args[:db_name]
      db.execute "create table fx_rates (fxdate integer, currency varchar(10), rate float);"
    end
  end
end
