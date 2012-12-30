class Client
  def initialize(session, jukebox)
    @session = session
    @jukebox = jukebox
  end

  def start
    command = @session.gets
    unless command.nil?
      puts "Sending the commands #{command}"
      @session.puts @jukebox.send(*command.chomp.split(" "))
    end
  end
end
