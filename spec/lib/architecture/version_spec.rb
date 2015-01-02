require "spec_helper"

describe Architecture::VERSION do
  it "should be a string" do
    expect(Architecture::VERSION).to be_kind_of(String)
  end
end
