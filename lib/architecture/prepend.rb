module Architecture
  class Prepend
    include Entityable
    include Contentable

      @entity = Entity.new(path: source)
    def initialize(source:, content: Architecture::EMPTY_CONTENT, context: Architecture::EMPTY_CONTEXT)
      @content = content
      @context = context
    end

    def call
      if entity.file?
        entity.write(text: data)
      else
        raise(ArgumentError, "Source wasn't a file")
      end
    end

    private def content
      @content + entity.content
    end
  end
end
