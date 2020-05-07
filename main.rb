require_relative "libs/style"
require_relative "libs/gameplay"

def quit_game
  puts "\nHave a nice day! :)".green_highlight
  exit
end

loop do
  Gameplay.new.play

  puts "\nWould you like to play again?(yes/no)"
  play_again = gets.chomp

  break unless play_again == "yes" || play_again == "y"
end

quit_game
