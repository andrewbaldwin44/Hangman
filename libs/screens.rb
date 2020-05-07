module Screens
  LINE = "-"*50
  RETURN = "Hit Enter to return".center(50)

  def game_commands
    puts <<~HEREDOC
      Game commands:  :s - save                 :da - delete all saves
                      :l - load                 :q - quit
                      :d - delete save
    HEREDOC
  end

  def welcome_header
    puts <<~HEREDOC

      #{"Welcome to HANGMAN!".blue_highlight.center(60)}
      #{LINE}

      #{"You have #{7-turns} #{turns == 6 ? "try" : "tries"} left to guess the word!".center(50)}
      Each turn you can either guess a letter or guess the whole word!

    HEREDOC
    game_commands
  end

  def main_screen
    welcome_header

    hangman_display = hangman
    puts "#{hangman_display[turns]}\n\n"
    print word_completion.join(" ").center(25)

    puts "\n\n\n#{status}"
    puts "Previous guesses: #{previous_guesses.join(" ")}"
    print "Enter your guess: "
  end

  def load_header
    <<~HEREDOC

      #{"Saves".yellow_highlight.center(60)}
      #{LINE}

      To load a save, please enter the corresponding number
      #{RETURN}

    HEREDOC
  end

  def delete_header
    <<~HEREDOC

      #{"Delete a Save".red_highlight.center(60)}
      #{LINE}

      To delete a save, please enter the corresponding number
      #{RETURN}

    HEREDOC
  end

  def saves_screen
    puts "\n\n"
    unless saves_directory.empty?
      saves_directory.each_with_index do |filename, index|
        puts "      #{index+1} - #{clean_filename(filename)}"
      end
    else
      puts "     You don't have any saves yet!"
    end

    puts "\n\n#{status}"
  end
end
