require "architecture"

module Architecture
  class DSL
    def initialize(source:, destination:)
      @source = source
      @destination = destination

      yield
    end

    private def copy(name:, as: name, context: {})
      ::Architecture::Copy.new(source: source(name), destination: destination(as), context: context).call
    end

    private def move(name:, as:)
      ::Architecture::Move.new(source: path, destination: as).call
    end

    private def create(path:, content:, context: {})
      ::Architecture::Create.new(source: path, content: content, context: context).call
    end

    private def delete(path:)
      ::Architecture::Delete.new(source: path).call
    end

    private def replace(path:, search:, content:)
      ::Architecture::Replace.new(source: path, search: search, content: content).call
    end

    private def prepend(path:, content:, context: {})
      ::Architecture::Prepend.new(source: path, content: content, context: context).call
    end

    private def append(path:, content:)
      ::Architecture::Append.new(source: path, content: content, context: context).call
    end

    private def overwrite(path:, content:, context: {})
      ::Architecture::Overwrite.new(source: path, content: content, context: context).call
    end

    private def within(path:, &block)
      ::Architecture::DSL.new(source: source(path), destination: destination(path), &block).call
    end

    private def source(path)
      join(@source, path)
    end

    private def destination(path)
      join(@destination, path)
    end

    private def join(*paths)
      ::File.join(*paths)
    end
  end
end

def architecture(source:, destination:, &block)
  ::Architecture::DSL.new(source: source, destination: destination, &block)
end
