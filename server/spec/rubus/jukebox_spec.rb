require_relative "../../lib/rubus.rb"
require 'rspec'

describe Rubus::Jukebox do
  before do
    @session = double(:session)
    @session.stub(:login!)
    @session.stub(:on)

    @user = double(:user)
    @player = double(:player)

    IO.stub(:read)

    Hallon::Session.stub(:initialize).and_return(@session)
    Hallon::User.stub(:new).and_return(@user)
    Hallon::Player.stub(:new).and_return(@player)
  end

  describe ".initialize" do
    it "should set all the required ivars" do
      @session.should_receive(:on).with(:end_of_track)

      jb = Rubus::Jukebox.new
      jb.session.should be
      jb.user.should be
      jb.player.should be
      jb.queue.should be_an_instance_of(Rubus::TrackQueue)
      jb.now_playing.should be_nil
    end
  end

  describe "instance methods" do
    before do
      @jb = Rubus::Jukebox.new
      Hallon::Track.stub(:new)
    end

    describe "#enqueue" do
      it "should create a new hallon track" do
        track = double(:track)
        track.stub(:load)
        Hallon::Track.should_receive(:new).with(track).and_return(track)
        @jb.enqueue(track)
      end

      context "the queue does not include the track" do
        it "should enqueue the track" do
          track = double(:track)
          track.stub(:load)
          expect { @jb.enqueue(track) }.to change(@jb, :queue).by(1)
        end
      end
      context "the queue includes the given track" do

      end
      context "nothing is playing" do

      end
    end
  end
end
