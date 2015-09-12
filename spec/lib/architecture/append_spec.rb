require "spec_helper"

RSpec.describe Architecture::Append do
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

  let("file") do
    "start"
  end

  let("result") do
    file + content
  end

  before("each") do
    allow(entity).to receive("file?").and_return(true)
    allow(entity).to receive("content").and_return(file)
    allow(entity).to receive("write").and_return(false)
    allow(append).to receive("entity").and_return(entity)
  end

  describe ".new" do
    let("append") do
      described_class.new(source: source, content: content, context: contexts)
    end

    context "with a file as source" do
      it "copies the file" do
        allow(entity).to receive("file?").and_return(true)
        expect(entity).to receive("write").with(text: result)
        append
      end
    end

    context "with a context" do
      it "renders the context" do
        # ...
      end
    end

    context "with a directory as source" do
      it "raises an exception" do
        allow(entity).to receive("file?").and_return(false)
        expect { append }.to raise_exception(ArgumentError, "Source wasn't a file")
        append
      end
    end
  end
end
