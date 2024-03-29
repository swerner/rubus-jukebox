module Rubus
  class Jukebox
    attr_reader :session, :user, :player, :queue, :now_playing
    def initialize
      @session = Hallon::Session.initialize IO.read('./spotify_appkey.key')
      @session.login!(ENV['SPOTIFY_USER'], ENV['SPOTIFY_PASS'])
      @user = Hallon::User.new(ENV["SPOTIFY_USER"])
      @queue = Rubus::TrackQueue.new
      @now_playing = nil
      @player = Hallon::Player.new(Hallon::OpenAL)

      @session.on(:end_of_track) do
        handle_track_ending
      end
    end

    def enqueue(track)
      track = Hallon::Track.new(track).load
      @queue << track unless @queue.include?(track)
      play(@queue.pop) if @now_playing.nil?
    end

    def handle_track_ending
      play(@queue.pop) if @queue.length > 0
    end

    def playlists
      @user.published.load.contents.find_all
    end

    def starred
      starred = Rubus::TrackQueue.new
      @user.starred.load.tracks.each do |track|
        starred << track.load
      end

      starred.to_json
    end

    def play(track = @now_playing)
      @now_playing = track.to_s
      @player.play track.id
    end

    def stop
      @player.stop
      @now_playing = nil
    end

    def now_playing
      @now_playing
    end
  end
end
