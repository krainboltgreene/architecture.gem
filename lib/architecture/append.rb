module Architecture
  class Append
    include Entityable
    include Contentable

    def initialize(source:, content: Architecture::EMPTY_CONTENT, context: Architecture::EMPTY_CONTEXT)
      @entity = source
      @content = content
      @context = context

      if entity.file?
        entity.write(text: data)
      else
        raise(ArgumentError, "Source wasn't a file")
      end
    end

    private def content
      entity.content + @content
    end
  end
end
