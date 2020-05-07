module Screens
  LINE = "-"*50

  def welcome
    puts <<~HEREDOC

      #{"Welcome to HANGMAN!".blue_highlight.center(60)}
      #{LINE}

      #{"You have #{7-turns} #{turns == 6 ? "try" : "tries"} left to guess the word!".center(50)}
      Each turn you can either guess a letter or guess the whole word!

      Game commands:  :s - save                 :da - delete all saves
                      :l - load                 :x - exit
                      :d - delete save

    HEREDOC
  end

  def main_screen
    welcome

    @hangman_display ||= hangman
    puts "#{@hangman_display[turns]}\n\n"
    print word_completion.join(" ").center(25)

    puts "\n\n\n#{status}"
    puts "Previous guesses: #{previous_guesses.join(" ")}"
    print "Enter your guess: "
  end

  def load_screen
    puts <<~HEREDOC

      #{"Saves".yellow_highlight.center(60)}
      #{LINE}

      To load a save, please enter the corresponding number

    HEREDOC

    Dir.glob('saves/*').each_with_index do |filename, index|
      puts "      #{index+1} - #{filename.split("/")[1].split(".")[0]}"
    end

    puts "\n\n\n#{status}"
  end
end
