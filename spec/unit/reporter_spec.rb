require 'spec_helper'
# require_relative '../../lib/inspector_juve/reporter'
include InspectorJuve

describe Reporter do
  it "accept new weakpoint entries" do
    reporter = Reporter.new
    reporter << entry = double(:entry)
    reporter.entries.should include(entry)
  end

  it "should report to stdout" do
    reporter = Reporter.new
    reporter << entry = double(:weakpoint, :to_s => "a message")
    capture_output_from(reporter) do |output|
      reporter.report
      output.should == 'a message'
    end
  end
end
