require_relative "libs/style"
require_relative "libs/gameplay"

loop do
  Gameplay.new.play

  puts "\nWould you like to play again?(yes/no)"
  play_again = gets.chomp

  break unless play_again == "yes" || play_again == "y"
end
puts "\nHave a nice day! :)".green_highlight
