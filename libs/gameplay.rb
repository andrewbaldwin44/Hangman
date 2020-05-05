require_relative "display"

class Gameplay
  private

  include Display

  WORD = /[[:alpha:]]/
  SINGLE_LETTER = /^[[:alpha:]]$/

  def initialize
    @selected_word = select_word
    @word_completion = ('_' * selected_word.length).chars
    @previous_guesses = []
    @errors = "\n"
    @turns = 0
  end

  attr_accessor :word_completion, :guess, :errors
  attr_reader :selected_word, :previous_guesses
  attr_writer :turns

  def select_word
    hangman_words = File.readlines("5desk.txt")
                        .keep_if{ |word| word.length.between?(5, 12) }
                        .map{ |word| word.strip.downcase}
    hangman_words[Random.rand(hangman_words.length)].chars
  end

  protected
  attr_reader :turns

  public

  def play
    hangman_display = hangman

    clear_screen
    welcome

    puts "#{hangman_display[turns]}\n\n"
    print word_completion.join(" ").center(25)

    puts "\n\n\n#{errors}"
    puts "Previous guesses: #{previous_guesses.join(" ")}"
    print "Enter your guess: "
    get_guess unless end_game?
  end

  private

  def get_guess
    @guess = gets.chomp.strip.downcase
    @errors = "\n"

    if !guess.match(WORD) || previous_guesses.include?(guess)
      @errors = invalid_guess
    else
      update_game
    end

    play
  end

  def update_game
    if guess.match(SINGLE_LETTER)
      correct = selected_word.each_index.select do |index|
        word_completion[index] = guess if selected_word[index] == guess
      end
    else
      correct = []
    end

    previous_guesses << guess

    if guess == selected_word.join
      self.word_completion = selected_word
    elsif correct.empty?
      self.turns += 1
    end
  end

  def end_game?
    if word_completion == selected_word
      winner
    elsif turns == 7
      loser
    else
      return false
    end
    true
  end
end
