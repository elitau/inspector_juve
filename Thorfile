require 'yard'
require './lib/inspector_juve/weakpoints/no_super_call'
require './lib/inspector_juve/weakpoints/dependency_on_foreign_variables'

class Weakpoints < Thor

  desc 'create_ast', 'Runs yard in given folder to generate the AST for code in the folder'
  def create_ast(db_folder, folder_with_ruby_code)
    system("yardoc --db #{db_folder} -n #{folder_with_ruby_code}")
  end

  desc 'search', 'search missing super call in overwritten method'
  def search(folder_with_ruby_code)
    db_folder = yardoc_objects_folder(folder_with_ruby_code)
    create_ast(db_folder, folder_with_ruby_code) unless File.exists?(db_folder)
    NoSuperCall.new(db_folder).search
    DependencyOnForeignVariables.new(db_folder).search
  end

  private
  def yardoc_objects_folder(folder_with_ruby_code)
    code_name = File.expand_path(folder_with_ruby_code).to_s.split('/')[-3..-1].join('_')
    File.join(folder_with_ruby_code, ".#{code_name}")
  end
end
