require "spec_helper"
module InspectorJuve
  describe MissingSuperInMethodMissing do

    it "should search successfully" do
      reporter = []
      weakpoint = MissingSuperInMethodMissing.new(
                    object_repository: object_repository_stub(:method_missing),
                    reporter: reporter
                  )
      weakpoint.search
      reporter.size.should == 1
      mm_weakpoint = reporter.first
      mm_weakpoint.to_s.should == "MissingSuperInMethodMissingFixture#method_missing has no super call in missing_super_in_method_missing_fixture.rb:3"
    end

    # do not find wrong positives
    # it "should not find methods with super call" do
    #   reporter = []
    #   weakpoint = MissingSuperInMethodMissing.new(
    #                 object_repository: object_repository_stub(:method_missing),
    #                 reporter: reporter
    #               )
    #   weakpoint.search
    #   reporter.should_not be_empty
    #   mm_weakpoint = reporter.first
    # end

    def object_repository_stub(fixture_name)
      ObjectRepository.new(yardoc_objects_db_path)
    end
  end
end
