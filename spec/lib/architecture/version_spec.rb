require "spec_helper"

RSpec.describe Architecture::VERSION do
  it "is a string" do
    expect(Architecture::VERSION).to be_kind_of(String)
  end
end
