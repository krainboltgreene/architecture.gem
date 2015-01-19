require "architecture"

module Architecture
  class DSL
    def initialize(source:, destination:)
      @source = source
      @destination = destination

      yield(self)
    end

    def copy(name:, as: name, context: {})
      ::Architecture::Copy.new(source: source(name), destination: destination(as), context: context).call
    end

    def move(name:, as:)
      ::Architecture::Move.new(source: path, destination: as).call
    end

    def create(directory: nil, file: nil, content: nil, context: {})
      ::Architecture::Create.new(source: directory || file, content: content, context: context).call
    end

    def delete(directory: nil, file: nil)
      ::Architecture::Delete.new(source: directory || file).call
    end

    def replace(file: nil, search:, content:)
      ::Architecture::Replace.new(source: file, search: search, content: content).call
    end

    def prepend(file: nil, content:, context: {})
      ::Architecture::Prepend.new(source: file, content: content, context: context).call
    end

    def append(file: nil, content:, context: {})
      ::Architecture::Append.new(source: file, content: content, context: context).call
    end

    def overwrite(file: nil, content:, context: {})
      ::Architecture::Overwrite.new(source: file, content: content, context: context).call
    end

    def within(source: nil, destination: nil, &block)
      ::Architecture::DSL.new(source: source(path), destination: destination(path), &block).call
    end

    def source(path)
      join(@source, path)
    end

    def destination(path)
      join(@destination, path)
    end

    private def join(*paths)
      ::File.join(*paths)
    end
  end
end
