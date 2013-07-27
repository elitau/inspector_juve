require 'yard'
require './lib/inspector_juve/weakpoints/no_super_call'
require './lib/inspector_juve/weakpoints/dependency_on_foreign_variables'

class Weakpoints < Thor

  desc 'create_ast', 'Runs yard in given folder to generate the AST for code in the folder'
  def create_ast(folder_with_ruby_code)
    system("yardoc -n #{folder_with_ruby_code}/spec/fixtures")
  end

  desc 'search', 'search missing super call in overwritten method'
  def search(code_folder)
    create_ast(code_folder)
    NoSuperCall.new(File.join(code_folder, '.yardoc')).search
    DependencyOnForeignVariables.new(File.join(code_folder, '.yardoc')).search
  end
end
