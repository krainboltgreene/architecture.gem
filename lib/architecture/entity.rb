module Architecture
  class Entity
    def initialize(path:)
      @path = path
    end

    def location
      ::File.expand_path(location)
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

    def copy(entity:)
      system("cp #{location} #{entity.location}")
    end

    def move(entity:)
      system("mv #{location} #{entity.location}")
    end

    def delete
      system("rm -rf #{location}")
    end

    def create
      system("mkdir -p #{location}")
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
      system("file --mime-type --brief #{location}")
    end

    private def system(command)
      `#{command}`
    end
  end
end
