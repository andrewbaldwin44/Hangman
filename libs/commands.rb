module Commands
  def command?
    guess.include?(":")
  end

  def run_command
    command = guess[1..-1]

    case command
    when "s" then save
    when "l" then load
    when "d" then delete
    when "da" then delete_all
    when "q" then quit_game
    else
      self.status = invalid_command
    end
  end
end
