module Rubus
  class Track
    attr_accessor :id, :name, :artist

    def initialize(track)
      @id = track.to_link.to_str
      @name = track.name
      @artist = track.artist.load.name
    end

    def to_s
      "#{artist} - #{name}"
    end
  end
end
