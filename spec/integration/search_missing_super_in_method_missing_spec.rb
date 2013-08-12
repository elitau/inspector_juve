require 'spec_helper'

describe "Search for missing super in method_missing methods" do
  before(:each) do
    run_yardoc_for_fixtures_folder
  end

  after(:each) do
    destroy_fixture_yardocs
  end

  it "should list access to foreign variables by modules" do
    localizer = InspectorJuve::MissingSuperInMethodMissing.new(
                 object_repository: object_repository_for_fixtures
               )
    capture_output_from(localizer) do |output|
      localizer.search
      output.should include('Method ClassWithBadMethodMissing#method_missing has no super call')
    end
  end

  def object_repository_for_fixtures
    InspectorJuve::ObjectRepository.new yardoc_objects_db_path
  end
end
