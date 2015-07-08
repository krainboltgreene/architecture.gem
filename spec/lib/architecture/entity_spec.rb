require "spec_helper"

RSpec.describe Architecture::Entity do
  let("path") do
    "foo/bar/baz"
  end

  let("entity") do
    described_class.new(path: path)
  end

  let("engine") do
    double(File)
  end

  before("each") do
    allow(entity).to receive("system")
  end

  describe "#directory?" do
    let("directory?") do
      entity.directory?
    end

    context "when path points to a directory" do
      it "returns true" do
        allow(entity).to receive("type").and_return("application/x-directory")
        expect(directory?).to be(true)
      end
    end

    context "when path points to a file" do
      it "returns false" do
        allow(entity).to receive("type").and_return("application/x-file")
        expect(directory?).to be(false)
      end
    end
  end

  describe "#file?" do
    let("file?") do
      entity.file?
    end

    before(:each) do
      allow(entity).to receive("type").and_return(type)
    end

    context "when path points to a file" do
      let("type") do
        "application/x-file"
      end
      it "returns true" do
        expect(file?).to be(true)
      end
    end

    context "when path points to a directory" do
      let("type") do
        "application/x-directory"
      end
      it "returns false" do
        expect(file?).to be(false)
      end
    end
  end

  describe "#create" do
    let("create") do
      entity.create(engine: engine)
    end

    it "calls the system" do
      allow(engine).to receive("expand_path").and_return(path)
      expect(entity).to receive("system")
      create
    end
  end

  describe "#delete" do
    let("delete") do
      entity.delete
    end

    it "calls the system" do
      allow(engine).to receive("expand_path").and_return(path)
      expect(entity).to receive("system")
      delete
    end
  end

  describe "#move" do
    let("move") do
      entity.move(entity: entity)
    end

    it "calls the system" do
      allow(engine).to receive("expand_path").and_return(path)
      expect(entity).to receive("system")
      move
    end
  end

  describe "#copy" do
    let("copy") do
      entity.copy(entity: entity)
    end

    it "calls the system" do
      allow(engine).to receive("expand_path").and_return(path)
      expect(entity).to receive("system")
      copy
    end
  end

  describe "#write" do
    let("write") do
      entity.write(text: "foo", engine: engine)
    end

    it "writes to the engine" do
      allow(engine).to receive("expand_path").and_return(path)
      expect(engine).to receive("write")
      write
    end
  end

  describe "#content" do
    let("content") do
      entity.content(engine: engine)
    end

    context "with a path that points to a file" do
      it "reads from the engine" do
        allow(entity).to receive("type").and_return("application/x-file")
        allow(engine).to receive("expand_path").and_return(path)
        expect(engine).to receive("read")
        content
      end
    end

    context "with a path that points to a directory" do
      it "returns a empty string" do
        allow(entity).to receive("type").and_return("application/x-directory")
        expect(content).to eq("")
      end
    end
  end

  describe "#location" do
    let("location") do
      entity.location(engine: engine)
    end

    context "if engine responds to expand_path" do
      it "calls expand_path on the engine" do
        expect(engine).to receive("expand_path")
        location
      end
    end

    context "if engine doesn't respond to expand_path" do
      it "returns the path" do
        expect(location).to eq(path)
      end
    end
  end
end
