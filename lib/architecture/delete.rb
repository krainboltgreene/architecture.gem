module Architecture
  class Delete
    include Entityable

    def initialize(source:)
      @entity = source
    end

    def call
      entity.delete
    end
  end
end
