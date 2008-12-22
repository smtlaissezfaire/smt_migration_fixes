require "rubygems"
require "spec"
require "activerecord"

current_dir = File.dirname(__FILE__)
lib_dir = "#{current_dir}/../lib"

require "#{lib_dir}/smt"
require "#{lib_dir}/smt/migration_fixes"
require "#{current_dir}/../init"
