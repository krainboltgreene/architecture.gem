module Architecture
  module Contentable
    private def data
      ::Mustache.render(content, context)
    end

    private def content
      @content
    end

    private def context
      @context
    end
  end
end
