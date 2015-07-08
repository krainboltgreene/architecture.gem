module Architecture
  class Create
    include Entityable
    include Contentable

    def initialize(source:, content: Architecture::EMPTY_CONTENT, context: Architecture::EMPTY_CONTEXT)
      @entity = source
      @content = content
      @context = context
    end

    def call
      if content.nil? || context.empty?
        entity.create
      else
        entity.write(text: data)
      end
    end
  end
end
