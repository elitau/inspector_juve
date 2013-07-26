require 'spec_helper'

describe "Search for bad instance variable access" do
  before(:each) do
    run_yardoc_for_fixtures_folder
  end

  after(:each) do
    destroy_fixture_yardocs
  end

  it "should list access to foreign variables by modules" do

    execute search
  end
end
