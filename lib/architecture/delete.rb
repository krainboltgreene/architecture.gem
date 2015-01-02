module Architecture
  class Delete
    include Entityable

    def initialize(source:)
      @entity = Entity.new(path: source)
    end

    def call
      `rm -rf #{entity.location}`
    end
  end
end
