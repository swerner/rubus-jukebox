require File.join( File.dirname(__FILE__), *%w{../ application})
require 'rspec'
require 'rack/test'
require 'json'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

describe 'The Jukebox UI' do
  before do
    @jukebox = double(:jukebox)
    Net::Telnet.stub(:new).and_return(@jukebox)
    @jukebox.stub(:close)
  end

  def app
    Sinatra::Application
  end

  describe "/" do
    before do
      starred = [{id: "abc123", name: "test", artist: "test"}]
      @jukebox.stub(:cmd).with("starred").and_return(starred.to_json)
    end

    it "is successful" do
      get '/'
      last_response.should be_successful
    end
  end
end
