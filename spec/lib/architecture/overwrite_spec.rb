require "spec_helper"

RSpec.describe Architecture::Overwrite do
  let("entity") do
    instance_double(Architecture::Entity)
  end

  let("source") do
    "path"
  end

  let("content") do
    "end"
  end

  let("contexts") do
    {}
  end

  let("overwrite") do
    described_class.new(source: source, content: content, context: contexts)
  end

  let("file") do
    "start"
  end

  let("result") do
    content
  end

  before("each") do
    allow(entity).to receive("file?").and_return(true)
    allow(entity).to receive("content").and_return(file)
    allow(entity).to receive("write").and_return(false)
    allow(overwrite).to receive("entity").and_return(entity)
  end

  describe "#call" do
    let("call") do
      overwrite.call
    end

    context "with a file as source" do
      before("each") do
        allow(entity).to receive("file?").and_return(true)
      end

      it "copies the file" do
        expect(entity).to receive("write").with(text: result)
        call
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

      it "raises an exception" do
        expect { call }.to raise_exception(ArgumentError, "Source wasn't a file")
      end
    end
  end
end
