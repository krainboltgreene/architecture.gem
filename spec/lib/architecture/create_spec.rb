require "spec_helper"

RSpec.describe Architecture::Create do
  let("entity") do
    instance_double(Architecture::Entity)
  end

  let("source") do
    "old"
  end

  let("content") do
    "{{foo}}"
  end

  let("contexts") do
    {}
  end

  let("create") do
    described_class.new(source: source, content: content, context: contexts)
  end

  describe "#call" do
    let("call") do
      create.call
    end

    before("each") do
      allow(create).to receive("entity").and_return(entity)
      allow(entity).to receive("location").and_return(source)
    end

    after("each") do
      call
    end

    context "with a file as source" do
      before("each") do
        allow(entity).to receive("file?").and_return(true)
      end

      context "with a context" do
        let("contexts") do
          {
            "foo" => "bar"
          }
        end

        it "creates a file with the rendered content" do
          expect(entity).to receive("write").with(text: "bar")
        end
      end

      context "without a context" do
        it "copies the file" do
          expect(entity).to receive("create")
        end
      end
    end

    context "with a directory as source" do
      let("content") do
        nil
      end

      it "creates the directory" do
        expect(entity).to receive("create")
      end
    end
  end
end
