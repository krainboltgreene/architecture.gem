require "architecture"

module Architecture
  class DSL
    def initialize(source:, destination:)
      @source = source
      @destination = destination

      yield(self)
    end

    def copy(file: nil, directory: nil, as: nil, context: {})
      ::Architecture::Copy.new(source: source(directory || file), destination: destination(as || directory || file), context: context).call
    end

    def move(file: nil, directory: nil, as:)
      ::Architecture::Move.new(source: directory || file, destination: as).call
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
      ::Architecture::DSL.new(source: source(source), destination: destination(destination), &block)
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
