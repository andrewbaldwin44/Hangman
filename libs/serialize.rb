module Serialize
  @@serializer = Marshal

  def command
    command = guess[1..-1]

    case command
    when "s" then save
    when "l" then load
    else
      self.status = invalid_command
    end
  end

  def save
    save_data = {
      selected_word: selected_word,
      word_completion: word_completion,
      previous_guesses: previous_guesses,
      status: status,
      turns: turns
    }
    write_to_file(@@serializer.dump(save_data))
  end

  def write_to_file(data)
    save_name = get_save_name
    filename = "#{save_name}.dump"
    Dir.mkdir('saves') unless Dir.exists?('saves')
    File.open("saves/#{filename}", "w"){ |file| file.write(data)}
  end

  def get_save_name
    main_screen
    puts
    print "Enter a name for the save: "
    save_name = gets.chomp

    if save_name.include?(" ") || save_name.include?(".")
      self.status = "Please do not include periods or spaces in the filename".red_highlight
      save_name = get_save_name
    end
    self.status = "Game saved!".green_highlight
    save_name
  end

  def load
    clear_screen
    load_screen

    load_file = get_file

    load_data = @@serializer.parse(File.readlines(load_file))

    self.selected_word = load_data[selected_word]
    self.word_completion = load_data[word_completion]
    self.previous_guesses = load_data[previous_guesses]
    self.status = load_data[status]
    self.turns = load_data[turns]
  end

  def get_file
    print "> "
    file_index = gets.chomp.to_i

    if file_index > Dir.glob('saves/*').length
      self.status = "Please enter a valid number, corresponding to the save file"
      file_index = get_file
    end

    Dir.glob('saves/*')[file_index]
  end
end
