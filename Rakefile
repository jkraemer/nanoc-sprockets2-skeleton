require 'nanoc3/tasks'

# PROJECT_PATH = File.dirname(__FILE__)
# LIB_PATH = File.join PROJECT_PATH , 'lib'
# $:.unshift LIB_PATH
# require 'default.rb'

Dir['tasks/*.rake'].sort.each { |rakefile| load rakefile }

task :default => [:clean, :auto]

