module Architecture
  class Copy
    include Replicatable
    include Contentable

    def initialize(source:, destination:, context: Architecture::EMPTY_CONTEXT)
      @origin = source
      @clone = destination
      @context = context

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
