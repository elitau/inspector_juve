require 'yard'
require './lib/inspector_juve'

class Weakpoints < Thor
  include Thor::Actions

  Output.instance.fancy

  desc 'create_ast', 'Runs yard in given folder to generate the AST for code in the folder'
  def create_ast(db_folder, folder_with_ruby_code)
    Output.instance.decorated_header "CREATING YARD OBJECT DATABASE"
    run("yardoc --db #{db_folder} -n #{folder_with_ruby_code}", :capture => true)
  end

  desc 'search FOLDER_WITH_RUBY_CODE', 'search for weakpoints in FOLDER_WITH_RUBY_CODE'
  def search(folder_with_ruby_code)
    db_folder = yardoc_objects_folder(folder_with_ruby_code)
    create_ast(db_folder, folder_with_ruby_code) unless use_cached_db?(db_folder)
    Output.instance.decorated_header "SEARCHING FOR WEAKPOINTS"
    InspectorJuve.run(db_folder)
  end

  private
  def yardoc_objects_folder(folder_with_ruby_code)
    code_name = File.expand_path(folder_with_ruby_code).to_s.split('/')[-3..-1].join('_')
    File.join(folder_with_ruby_code, ".#{code_name}_yardoc")
  end

  def use_cached_db?(db_folder)
    File.exists?(db_folder) and not db_folder == './.Dropbox_Masterthesis_static_analysis_yardoc'
  end
end
