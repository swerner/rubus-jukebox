require 'yaml'
require 'socket'
require 'observer'
require 'thread'
require 'pry'

require File.join( File.dirname(__FILE__), *%w{lib rubus})
require File.join( File.dirname(__FILE__), *%w{lib client})

config = YAML.load_file("config/config.yaml")
Thread.abort_on_exception = config['debug']

puts "Starting the server on port #{config['port']}"
server = TCPServer.new(config['port'])
jukebox = Rubus::Jukebox.new
threads = []

while (session = server.accept)
  threads << Thread.new(session) do |s|
    puts "Accepting connection from some jerk at #{s.addr[2]}."
    c = Client.new(s,jukebox)
    Thread.current['client'] = c
    c.start
    s.close
  end
end
