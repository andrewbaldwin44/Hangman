module Serialize
  @@serializer = Marshal

  def saves_directory
    Dir.glob('saves/*')
  end

  def get_file_path(filename)
    "saves/#{filename}.save"
  end

  def clean_filename(file_path)
    file_path.split("/")[1].split(".")[0]
  end

  def save
    save_data =
      instance_variables.each_with_object({}) do|variable, object|
        object[variable] = instance_variable_get(variable)
      end

    write_to_file(@@serializer.dump(save_data))
  end

  def write_to_file(data)
    save_name = get_save_name

    if save_name
      Dir.mkdir('saves') unless Dir.exists?('saves')
      File.open(get_file_path(save_name), "w"){ |file| file.write(data)}
    end
  end

  def get_save_name
    self.status = "Hit Enter to return".italic

    clear_screen
    main_screen
    puts
    print "Enter a name for the save: "
    save_name = gets.chomp

    if save_name.include?(" ") || save_name.include?(".")
      self.status = "Please do not include periods or spaces in the filename".red_highlight
      save_name = get_save_name
    elsif saves_directory.include?(get_file_path(save_name))
      puts "This save already exists, would you like to overwrite it?(y/n)"
      
      unless confirmation?
        clear_status
        return
      end
    elsif save_name.empty?
      clear_status
      return
    end

    self.status = "Game saved!".green_highlight
    save_name
  end

  def load
    clear_status

    load_file = get_file(load_header)

    if load_file
      load_data = @@serializer.load(File.read(load_file))

      load_data.each do |variable, value|
        instance_variable_set(variable, value)
      end

      self.status = "#{clean_filename(load_file)} was loaded".yellow_highlight
    end
  end

  def delete
    clear_status

    delete_file = get_file(delete_header)

    if delete_file
      clean_delete_filename = clean_filename(delete_file)

      puts "Are you sure you want to delete #{clean_delete_filename}?(y/n)"

      if confirmation?
        File.delete(delete_file)
        self.status = "#{clean_delete_filename} was deleted".red_highlight
      end
    end
  end

  def delete_all
    unless saves_directory.empty?
      puts "Are you sure you want to delete all your saves?(y/n)"

      if confirmation?
        saves_directory.each{ |file| File.delete(file)}
        self.status = "All save files were deleted".red_highlight
      end
    else
      self.status = "You don't have any saves!"
    end
  end

  def confirmation?
    confirmation = gets.chomp.downcase
    confirmation == "y" || confirmation == "yes"
  end

  def get_file(header)
    clear_screen
    puts header
    saves_screen
    print "> "

    input = gets.chomp
    file_index = input.to_i

    if input.empty? || saves_directory.empty?
      clear_status
      return
    elsif file_index == 0 || file_index > saves_directory.length
      self.status = "Please enter a valid number, corresponding to the save file".red_highlight
      file_index = get_file(header)
    end

    Dir.glob('saves/*')[file_index-1]
  end
end
