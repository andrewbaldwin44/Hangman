require_relative "screens"
require_relative "display"
require_relative "serialize"

class Gameplay
  include Screens
  include Display
  include Serialize

  WORD = /[[:alpha:]]/
  SINGLE_LETTER = /^[[:alpha:]]$/

  def initialize
    @screen = :main
    @selected_word = select_word
    @word_completion = ('_' * selected_word.length).chars
    @previous_guesses = []
    @status = "\n"
    @turns = 0
  end

  private

  attr_accessor :word_completion, :guess, :status
  attr_reader :screen, :selected_word, :previous_guesses
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
    clear_screen
    main_screen
    get_guess unless end_game?
  end

  private

  def get_guess
    @guess = gets.chomp.strip.downcase

    if guess.include?(":")
      command
    elsif !guess.match(WORD) || previous_guesses.include?(guess)
      @status = invalid_guess
    else
      @status = "\n"
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
