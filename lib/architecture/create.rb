module Architecture
  class Create
    include Entityable
    include Contentable

    def initialize(source:, content:, context:)
      @entity = Entity.new(path: source)
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
