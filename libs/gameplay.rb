require_relative "display"
class Gameplay
  include Display

  def initialize
    @selected_word = select_word
    @word_completion = ('_' * selected_word.length).chars
    @previous_guesses = []
    @errors = "\n"
    @turns = 0
  end

  attr_accessor :word_completion, :turns, :guess, :errors
  attr_reader :selected_word, :previous_guesses

  def select_word
    hangman_words = File.readlines("5desk.txt")
                        .keep_if{ |word| word.length.between?(5, 12) }
                        .map{ |word| word.strip.downcase}
    hangman_words[Random.rand(hangman_words.length)].chars
  end

  def play
    hangman_display = hangman

    clear_screen
    welcome

    puts "#{hangman_display[turns]}\n\n"
    print word_completion.join(" ").center(25)
    puts "\n\n\n#{errors}"
    puts "Previous guesses: #{previous_guesses.join(" ")}"
    print "Enter your guess: "
    get_guess
  end

  def get_guess
    @guess = gets.chomp.downcase
    @errors = "\n"

    single_letter = /^[^a-z]$/
    word = /[^a-z]/

    if guess == "" || guess.match(single_letter) || previous_guesses.include?(guess)
      @errors = invalid_guess
    elsif guess.match(word)
      end_game = end_game?
    else
      update_game
      end_game = end_game?
    end

    play unless end_game
  end

  def update_game
    correct = selected_word.each_index.select do |index|
      word_completion[index] = guess if selected_word[index] == guess
    end

    previous_guesses << guess
    self.turns += 1 if correct.length == 0
  end

  def end_game?
    if word_completion == selected_word || guess.chars == selected_word
      winner
    elsif turns == 7
      loser
    else
      return false
    end
    true
  end
end
