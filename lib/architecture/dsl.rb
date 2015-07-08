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

      @output.print("#{indentention}Copying #{a} to #{b}")

      Copy.new(source: a, destination: b, context: context)

      @output.puts(" succeeded.")

      if block_given? && directory
        within(directory: directory)
      end
    end

    def move(file: nil, directory: nil, as:, &block)
      a = Entity.new(id: directory || file, prefix: @source)
      b = Entity.new(id: as, prefix: @destination)

      @output.print("#{indentention}Moving #{a} to #{b}")

      Move.new(source: a, destination: b)

      @output.puts(" succeeded.")

      if block_given? && directory
        within(directory: directory)
      end
    end

    def create(file: nil, directory: nil, content: nil, context: EMPTY_CONTEXT, location: nil, &block)
      a = Entity.new(id: directory || file, prefix: location || @destination)

      @output.print("#{indentention}Creating #{a}")

      Create.new(source: a, content: content, context: context)

      @output.puts(" succeeded.")

      if block_given? && directory
        within(directory: directory)
      end
    end

    def delete(directory: nil, file: nil, location: nil)
      a = Entity.new(id: directory || file, prefix: location || @destination)

      @output.print("#{indentention}Deleting #{a}")

      Delete.new(source: a)

      @output.puts(" succeeded.")
    end

    def replace(file:, search:, content:, location: nil)
      a = Entity.new(id: directory || file, prefix: location || @destination)

      @output.print("#{indentention}Replacing content in #{a}")

      Replace.new(source: a, search: search, content: content)

      @output.puts(" succeeded.")
    end

    def prepend(file:, content:, context: Architecture::EMPTY_CONTEXT, location: nil)
      a = Entity.new(id: directory || file, prefix: location || @destination)

      @output.print("#{indentention}Prepending #{a} with content")


      Prepend.new(source: a, content: content, context: context)

      @output.puts(" succeeded.")
    end

    def append(file:, content:, context: Architecture::EMPTY_CONTEXT, location: nil)
      a = Entity.new(id: directory || file, prefix: location || @destination)

      @output.print("#{indentention}Appending #{a}")

      Append.new(source: a, content: content, context: context)

      @output.puts(" succeeded.")
    end

    def overwrite(file:, content:, context: Architecture::EMPTY_CONTEXT, location: nil)
      a = Entity.new(id: directory || file, prefix: location || @destination)

      @output.print("#{indentention}Appending #{a}")

      Overwrite.new(source: a, content: content, context: context)

      @output.puts(" succeeded.")
    end

    def within(directory: nil, source: join(@source, directory), destination: join(@destination, directory), &block)
      @output.print "#{indentention}Within #{destination}"

      self.class.new(source: source, destination: destination, output: @output, level: @level + 1, &block)
    end

    private def source
      @source
    end

    private def destination
      @destination
    end

    private def join(*ids)
      File.join(*ids)
    end

    private def indentention
      "\t" * @level
    end
  end
end
