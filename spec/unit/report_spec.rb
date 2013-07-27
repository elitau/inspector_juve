# require 'unit_spec_helper'
require_relative '../../lib/inspector_juve/report'
include InspectorJuve

describe Report do
  it "accept new weakpoint entries" do
    report = Report.new
    report << entry = double(:entry)
    report.entries.should include(entry)
  end
end
