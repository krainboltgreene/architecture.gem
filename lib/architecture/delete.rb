module Architecture
  class Delete
    include Entityable

    def initialize(source:)
      @entity = source

      entity.delete
    end
  end
end
