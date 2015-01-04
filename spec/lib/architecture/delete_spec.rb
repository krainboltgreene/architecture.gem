require "spec_helper"

RSpec.describe Architecture::Delete do
  let("entity") do
    instance_double(Architecture::Entity)
  end

  let("source") do
    "old"
  end

  let("delete") do
    described_class.new(source: source)
  end

  describe "#call" do
    let("call") do
      delete.call
    end

    before("each") do
      allow(delete).to receive("entity").and_return(entity)
      allow(entity).to receive("location").and_return(source)
    end

    after("each") do
      call
    end

    it "deletes the file" do
      expect(entity).to receive("delete")
    end
  end
end
