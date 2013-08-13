require 'spec_helper'

describe "Search for bad instance variable access" do
  before(:each) do
    run_yardoc_for_fixtures_folder
  end

  after(:each) do
    destroy_fixture_yardocs
  end

  it "should list access to foreign variables by modules" do
    reporter = []
    reporter.stub(:report)
    InspectorJuve.run yardoc_objects_db_path, reporter
    reporter.should_not be_empty
    error_message = 'Method BadModule#bad_module_method accesses instance variable @accessed_instance_variable'
    reporter.map(&:to_s).should include(error_message)

    # analyzer = DependencyOnForeignVariables.new(yardoc_objects_db_path)
    # capture_output_from(analyzer) do |output|
    #   analyzer.search
    #   output.should include('Method BadModule#bad_module_method accesses instance variable @accessed_instance_variable')
    # end
  end
end
