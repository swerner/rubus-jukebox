module Rubus
  class TrackQueue
    attr_accessor :queue

    def initialize
      @queue = []
    end

    def <<(track)
      @queue << Rubus::Track.new(track)
    end

    def pop
      @queue.pop
    end

    def to_json
      @queue.map(&:to_h).to_json
    end

    def length
      @queue.length
    end

    def include?(track)
      @queue.map(&:id).include?(track.to_link.to_str)
    end
  end
end
