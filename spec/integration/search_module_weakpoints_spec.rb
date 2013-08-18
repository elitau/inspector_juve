require 'spec_helper'

describe "Search for bad instance variable access" do
  before(:each) do
    run_yardoc_for_fixtures_folder
  end

  after(:each) do
    destroy_fixture_yardocs
  end

  it "should list access to foreign variables by modules" do
    reporters = []
    reporters.stub(:report)
    InspectorJuve.run yardoc_objects_db_path, reporters
    reporters.should_not be_empty
    error_message = 'BadModule#bad_module_method accesses instance variable @accessed_instance_variable in module_breaks_encapsulation.rb:4'
    reporter = reporters.find{ |r| r.localizer == DependencyOnForeignVariables}
    reporter.entries.map(&:to_s).should include(error_message)

    # analyzer = DependencyOnForeignVariables.new(yardoc_objects_db_path)
    # capture_output_from(analyzer) do |output|
    #   analyzer.search
    #   output.should include('Method BadModule#bad_module_method accesses instance variable @accessed_instance_variable')
    # end
  end
end
