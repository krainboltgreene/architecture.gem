module Architecture
  class Copy
    include Replicatable
    include Contentable

      @origin = Entity.new(path: source)
      @clone = Entity.new(path: destination)
    def initialize(source:, destination:, context: Architecture::EMPTY_CONTEXT)
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
