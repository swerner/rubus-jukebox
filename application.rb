require 'pry'
require 'coffee-script'
require 'haml'
require 'json'
require 'net/telnet'

require 'sinatra'

set :haml, :format => :html5

before do
  @jukebox = Net::Telnet::new("Host" => "localhost", "Port" => "12345")
end
after do
  @jukebox.close
end

get '/' do
  haml :index, locals: {
                         starred: @jukebox.cmd("starred")
                        }
end

get "/play/:trackid" do
  @jukebox.cmd("enqueue #{params[:trackid]}")
  content_type :json
  true
end

get "/application.js" do
  coffee :application
end

get "/queue.json" do
  content_type :json
  @jukebox.cmd("queue").to_json
end

get "/stop_music" do
  @jukebox.cmd("stop")
end

get '/now_playing.json' do
  content_type :json
  @jukebox.cmd("now_playing").to_json
end
