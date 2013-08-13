require "spec_helper"

module InspectorJuve
  describe ObjectRepository do
    # before(:each) do
    #   run_yardoc_for_fixtures_folder
    # end

    it "should return all methods" do
      object_repository = ObjectRepository.new(yardoc_objects_db_path)
      object_repository.all_methods.should_not be_empty
    end
  end
end
