module Architecture
  class Entity
    def initialize(path:)
      @path
    end

    def location
      ::File.expand_path(@location)
    end

    def content
      if file?
        ::File.read(location)
      else
        ""
      end
    end

    def write(text:)
      ::File.write(location, text)
    end

    private def path
      @path
    end

    def file?
      !directory?
    end

    def directory?
      type == "application/x-directory"
    end

    private def type
      `file --mime-type --brief #{location}`
    end
  end
end
