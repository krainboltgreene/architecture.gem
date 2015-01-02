module Architecture
  class Delete
    include Entityable

    def initialize(source:)
      @entity = Entity.new(path: source)
    end

    def call
      entity.delete
    end
  end
end
