require "spec_helper"

RSpec.describe Architecture::Move do
  let("clone") do
    instance_double(Architecture::Entity)
  end

  let("origin") do
    instance_double(Architecture::Entity)
  end

  let("source") do
    "old"
  end

  let("destination") do
    "new"
  end

  let("move") do
    described_class.new(source: source, destination: destination)
  end

  describe "#call" do
    let("call") do
      move.call
    end

    before("each") do
      allow(move).to receive("origin").and_return(origin)
      allow(move).to receive("clone").and_return(clone)
      allow(origin).to receive("location").and_return(source)
      allow(clone).to receive("location").and_return(destination)
    end

    after("each") do
      call
    end

    it "moves the file" do
      expect(origin).to receive("move").with(entity: clone)
    end
  end
end
