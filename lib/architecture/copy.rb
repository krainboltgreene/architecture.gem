module Architecture
  class Copy
    include Replicatable
    include Contentable

    def initialize(source:, destination:, context: {})
      @origin = Entity.new(path: source)
      @clone = Entity.new(path: destination)
      @context = context
    end

    def call
      if origin.file? && context.any?
        clone.write(text: data)
      else
        origin.copy(entity: clone)
      end
    end

    private def content
      origin.content
    end
  end
end
