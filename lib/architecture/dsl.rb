require "architecture"

module Architecture
  class DSL
    def initialize(source:, destination:, output: STDOUT, level: 0)
      @source = source
      @destination = destination
      @output = output
      @level = level

      yield(self)
    end

    def copy(file: nil, directory: nil, as: nil, context: EMPTY_CONTEXT, &block)
      a = Entity.new(id: directory || file, prefix: @source)
      b = Entity.new(id: as || directory || file, prefix: @destination)

      @output.print("#{indentention}Copying `#{truncate(a.to_s)}` to `#{truncate(b.to_s)}`")

      Copy.new(source: a, destination: b, context: context).call

      @output.puts(" succeeded.")

      if block_given? && directory
        within(directory: directory, &block)
      end
    end

    def move(file: nil, directory: nil, as:, &block)
      a = Entity.new(id: directory || file, prefix: @source)
      b = Entity.new(id: as, prefix: @destination)

      @output.print("#{indentention}Moving `#{truncate(a.to_s)}` to `#{truncate(b.to_s)}`")

      Move.new(source: a, destination: b).call

      @output.puts(" succeeded.")

      if block_given? && directory
        within(directory: directory, &block)
      end
    end

    def create(file: nil, directory: nil, content: nil, context: EMPTY_CONTEXT, location: nil, &block)
      a = Entity.new(id: directory || file, prefix: location || @destination)

      @output.print("#{indentention}Creating `#{truncate(a.to_s)}`")

      Create.new(source: a, content: content, context: context).call

      @output.puts(" succeeded.")

      if block_given? && directory
        within(directory: directory, &block)
      end
    end

    def delete(directory: nil, file: nil, location: nil)
      a = Entity.new(id: directory || file, prefix: location || @destination)

      @output.print("#{indentention}Deleting `#{truncate(a.to_s)}`")

      Delete.new(source: a).call

      @output.puts(" succeeded.")
    end

    def replace(file:, search:, content:, location: nil)
      a = Entity.new(id: file, prefix: location || @destination)

      @output.print("#{indentention}Replacing content in `#{truncate(a.to_s)}`")

      Replace.new(source: a, search: search, content: content).call

      @output.puts(" succeeded.")
    end

    def prepend(file:, content:, context: Architecture::EMPTY_CONTEXT, location: nil)
      a = Entity.new(id: file, prefix: location || @destination)

      @output.print("#{indentention}Prepending `#{truncate(a.to_s)}` with content")

      Prepend.new(source: a, content: content, context: context).call

      @output.puts(" succeeded.")
    end

    def append(file:, content:, context: Architecture::EMPTY_CONTEXT, location: nil)
      a = Entity.new(id: directory || file, prefix: location || @destination)

      @output.print("#{indentention}Appending `#{truncate(a.to_s)}` with content")

      Append.new(source: a, content: content, context: context).call

      @output.puts(" succeeded.")
    end

    def overwrite(file:, content:, context: Architecture::EMPTY_CONTEXT, location: nil)
      a = Entity.new(id: directory || file, prefix: location || @destination)

      @output.print("#{indentention}Overwriting `#{truncate(a.to_s)}` with content")

      Overwrite.new(source: a, content: content, context: context).call

      @output.puts(" succeeded.")
    end

    def within(directory: nil, source: @source, destination: @destination, &block)
      @output.puts "#{indentention}Within `#{truncate(join(@destination, directory || destination))}`"

      self.class.new(source: join(@source, directory || source), destination:  join(@destination, directory || destination), output: @output, level: @level + 1, &block)
    end

    private def join(*ids)
      File.join(*ids.compact)
    end

    private def indentention
      "  " * @level + "- "
    end

    private def truncate(path)
      path.split("/").last(@level + 1).join("/")
    end
  end
end
