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
      if context.any? && entity.file?
        clone.write(text: data)
      else
        `cp #{origin.location} #{clone.location}`
      end
    end

    private def content
      origin.content
    end
  end
end
