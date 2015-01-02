require "spec_helper"

RSpec.describe Architecture::Copy do
  let("entity") do
    instance_double(Architecture::Entity)
  end

  let("source") do
    "old"
  end

  let("destination") do
    "new"
  end

  let("contexts") do
    {}
  end

  let("copy") do
    described_class.new(source: source, destination: destination, context: contexts)
  end

  describe "#call" do
    let("call") do
      copy.call
    end

    context "with a file as source" do
      before("each") do
        allow(entity).to receive("file?").and_return(true)
      end

      it "copies the file" do
        # ...
      end
    end

    context "with a context" do
      it "renders the context" do
        # ...
      end
    end

    context "with a directory as source" do
      before("each") do
        allow(entity).to receive("file?").and_return(false)
      end

      it "calls to the system" do
        # ...
      end
    end
  end
end
