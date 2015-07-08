module Architecture
  class Replace
    include Entityable

      @entity = Entity.new(path: source)
    def initialize(source:, search: Architecture::EMPTY_PATTERN, content: Architecture::EMPTY_CONTENT)
      @search = search
      @content = content
    end

    def call
      if entity.file?
        entity.write(text: content)
      else
        raise(ArgumentError, "Source wasn't a file")
      end
    end

    private def content
      entity.content.gsub(search, @content)
    end

    private def search
      @search
    end
  end
end
