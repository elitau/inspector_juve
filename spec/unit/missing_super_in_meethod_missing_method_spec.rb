require "spec_helper"
module InspectorJuve
  describe MissingSuperInMethodMissing do
    before(:each) do
      run_yardoc_for_fixtures_folder
    end

    after(:each) do
      # destroy_fixture_yardocs
    end

    it "should search" do
      reporter = []
      weakpoint = MissingSuperInMethodMissing.new(
                    object_repository: object_repository_stub(:method_missing),
                    reporter: reporter
                  )
      weakpoint.search
      reporter.should_not be_empty
      mm_weakpoint = reporter.first
      mm_weakpoint.message.should == "Method ClassWithBadMethodMissing#method_missing has no super call"
    end

    def object_repository_stub(fixture_name)
      ObjectRepository.new(yardoc_objects_db_path)
    end
  end
end
