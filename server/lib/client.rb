class Client
  def initialize(session, jukebox)
    @session = session
    @jukebox = jukebox
  end

  def start
    command = @session.gets
    unless command.nil?
      command = command.chomp.split(" ")
      @session.puts @jukebox.send(command[0]) if command.length == 1
      @session.puts @jukebox.send(command[0], command[1]) if command.length == 2
    end
  end
end
