module Display
  def invalid_guess
    "Please guess a valid letter".red_highlight
  end

  def invalid_command
    "Sorry, that command was invalid".red_highlight
  end

  def winner
    puts "\n\n#{"You guessed the word! Congragulations!".green_highlight}"
  end

  def loser
    puts "\n\n#{"Game over for the hangman! You lose!".red_highlight}"
    puts "The word was #{selected_word.join}"
  end

  def hangman
    [
      %(
         _________
          |/
          |
          |
          |
          |
          |
          |___
      ),
      %(
         _________
          |/   |
          |
          |
          |
          |
          |
          |___
      ),
      %(
         _________
          |/   |
          |    O
          |
          |
          |
          |
          |___
      ),
      %(
         _________
          |/   |
          |    O
          |    |
          |    |
          |
          |
          |___
      ),
      %(
         _________
          |/   |
          |    O
          |   /|
          |    |
          |
          |
          |___
      ),
      %(
         _________
          |/   |
          |    O
          |   /|\\
          |    |
          |
          |
          |___
      ),
      %(
         _________
          |/   |
          |    O
          |   /|\\
          |    |
          |   /
          |
          |___
      ),
      %(
         _________
          |/   |
          |    O
          |   /|\\
          |    |
          |   / \\
          |
          |___
      )
    ]
  end

  def clear_screen
    print `clear`
  end
end
