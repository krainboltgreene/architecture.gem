module Architecture
  class Entity
    DIRECTORY_MIMETYPE = "application/x-directory"
    DEFAULT_ENGINE = ::File

    def initialize(path:)
      @path = path
    end

    def location(engine: DEFAULT_ENGINE)
      if engine.respond_to?("expand_path")
        engine.expand_path(path)
      else
        path
      end
    end

    def content(engine: DEFAULT_ENGINE)
      if file?(engine: engine)
        engine.read(location(engine: engine))
      else
        ""
      end
    end

    def write(text:, engine: DEFAULT_ENGINE)
      engine.write(location(engine: engine), text)
    end

    def copy(entity:, engine: DEFAULT_ENGINE)
      system("cp #{location(engine: engine)} #{entity.location(engine: engine)}")
    end

    def move(entity:, engine: DEFAULT_ENGINE)
      system("mv #{location(engine: engine)} #{entity.location(engine: engine)}")
    end

    def delete(engine: DEFAULT_ENGINE)
      system("rm -rf #{location(engine: engine)}")
    end

    def create(engine: DEFAULT_ENGINE)
      system("mkdir -p #{location(engine: engine)}")
    end

    def file?(engine: DEFAULT_ENGINE)
      !directory?(engine: engine)
    end

    def directory?(engine: DEFAULT_ENGINE)
      type(engine: engine) == DIRECTORY_MIMETYPE
    end

    private def path
      @path
    end

    private def type(engine: DEFAULT_ENGINE)
      system("file --mime-type --brief #{location(engine: engine)}")
    end

    private def system(command)
      `#{command}`
    end
  end
end
