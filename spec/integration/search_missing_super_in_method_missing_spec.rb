require 'spec_helper'

describe "Search for missing super in method_missing methods" do
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
    error_message = 'MissingSuperInMethodMissingFixture#method_missing has no super call'
    reporter.map(&:to_s).should include(error_message)
  end

  def object_repository_for_fixtures
    InspectorJuve::ObjectRepository.new yardoc_objects_db_path
  end
end
