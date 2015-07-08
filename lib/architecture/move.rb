module Architecture
  class Move
    include Replicatable

    def initialize(source:, destination:)
      @origin = source
      @clone = destination
    end

    def call
      origin.move(entity: clone)
    end
  end
end
