require 'spec_helper'

describe "Search for missing super in method_missing methods" do
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
    error_message = 'MissingSuperInMethodMissingFixture#method_missing has no super call in missing_super_in_method_missing_fixture.rb:3'
    reporter = reporters.find{ |r| r.localizer == MissingSuperInMethodMissing}
    reporter.entries.map(&:to_s).should include(error_message)
  end

  def object_repository_for_fixtures
    InspectorJuve::ObjectRepository.new yardoc_objects_db_path
  end
end
