require 'fileutils'
require_relative '../lib/inspector_juve'

def run_yardoc_for_fixtures_folder
  yard_command = "cd #{fixtures_path} && bundle exec yardoc --db #{yardoc_objects_db_path} -n ."
  `#{yard_command}`
end

def destroy_fixture_yardocs
  FileUtils.rm_rf(yardoc_objects_db_path)
end

def fixtures_path
  File.join(File.dirname(__FILE__), *%w[fixtures])
end

def yardoc_objects_db_path
  fixtures_path + "/.yardoc_#{unit_spec? ? 'unit' : 'integration'}"
end

def unit_spec?
  @example.location.include?("spec/unit")
  # File.dirname(__FILE__).include?('integration')
end

def capture_output_from(object)
  $output = ''
  def object.puts(arg)
    $output << arg.to_s
  end
  yield $output if block_given?
  $output
end
