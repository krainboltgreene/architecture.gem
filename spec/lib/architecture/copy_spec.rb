require "spec_helper"

RSpec.describe Architecture::Copy do
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

  let("contexts") do
    {}
  end

  let("content") do
    "{{foo}}"
  end

  let("copy") do
    described_class.new(source: source, destination: destination, context: contexts)
  end

  describe "#call" do
    let("call") do
      copy.call
    end

    before("each") do
      allow(copy).to receive("origin").and_return(origin)
      allow(copy).to receive("clone").and_return(clone)
      allow(origin).to receive("location").and_return(source)
      allow(origin).to receive("content").and_return(content)
      allow(clone).to receive("location").and_return(destination)
    end

    after("each") do
      call
    end

    context "with a file as source" do
      before("each") do
        allow(origin).to receive("file?").and_return(true)
      end

      context "without a context" do
        it "copies the file" do
          expect(origin).to receive("copy").with(entity: clone)
        end
      end

      context "with a context" do
        let("contexts") do
          {
            "foo" => "bar"
          }
        end

        it "creates a file with the rendered content" do
          expect(clone).to receive("write").with(text: "bar")
        end
      end
    end

    context "with a directory as source" do
      before("each") do
        allow(origin).to receive("file?").and_return(false)
      end

      it "copies the directory" do
        expect(origin).to receive("copy").with(entity: clone)
      end
    end
  end
end
