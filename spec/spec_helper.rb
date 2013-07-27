require 'fileutils'
require_relative '../lib/inspector_juve'

def run_yardoc_for_fixtures_folder
  yard_command = "cd #{fixtures_path} && bundle exec yardoc -n ."
  `#{yard_command}`
end

def destroy_fixture_yardocs
  FileUtils.rm_rf(yardoc_objects_db_path)
end

def fixtures_path
  File.join(File.dirname(__FILE__), *%w[fixtures])
end

def yardoc_objects_db_path
  fixtures_path + '/.yardoc'
end