# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

ROOT = File.expand_path(File.join __FILE__, '..', '..') unless defined? ROOT

require 'rubygems'
require 'bundler/setup'



