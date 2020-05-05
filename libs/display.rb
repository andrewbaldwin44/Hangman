module Display
  def welcome
    puts <<~HEREDOC

      #{"Welcome to HANGMAN!".blue_highlight.center(60)}
      #{"-"*50}

      #{"You have seven turns to guess the word!".center(50)}
      Each turn you can either guess a letter or guess the whole word!
    HEREDOC
  end

  def invalid_guess
    "Please guess a valid letter".red_highlight
  end

  def winner
    puts "\n#{"You guessed the word! Congragulations!".green_highlight}"
  end

  def loser
    puts "\n#{"Game over for the hangman! You lose!".red_highlight}"
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
