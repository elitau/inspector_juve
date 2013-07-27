# require 'unit_spec_helper'
require_relative '../../lib/inspector_juve/report'
include InspectorJuve

describe Report do
  it "accept new weakpoint entries" do
    report = Report.new
    report.add double(:entry)
  end
end
