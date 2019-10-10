def generate_random_word 
    words = File.read "5desk.txt"
    word = words.split(" ")

    random = rand(word.length + 1)
    word[random].downcase
end

$chosen_word = generate_random_word
$random_word = $chosen_word.split("")
$incorrect_guesses = 6
$blank_letters = ""
$is_saved = false

def blanks_setup
    counter = 0
    while counter < $random_word.length
        $blank_letters += "_"
        counter += 1
    end
    puts $blank_letters.split("").join(" ")
end

def blanks_replacement
    puts ""
    puts "Please guess a letter or enter 'save' to save your current game"
    guess_letter = gets.chomp.downcase

    if guess_letter == 'save'
        save_game
        return []
    elsif $random_word.include?(guess_letter)
        $random_word.each do |letter|
            if letter == guess_letter
                $blank_letters[$random_word.index(guess_letter)] = guess_letter
                $random_word[$random_word.index(guess_letter)] = ""
            end
        end
    else
        puts ""
        puts "Incorrect! You only have #{$incorrect_guesses} incorrect guesses left!"
        $incorrect_guesses -= 1
    end
        
    $blank_letters.split("")
end

def save_game
    puts ""
    puts 'Please enter a name for the file'
    file_name = gets.chomp.downcase

    if File.exists?("#{file_name}.txt")
        puts ""
        puts "This saved file name already exists"
        save_game
    else
        File.open("#{file_name}.txt", "w"){|file| file.puts "#{$blank_letters}-#{$random_word}-#{$chosen_word}-#{$incorrect_guesses}"}
        puts "#{file_name} has been saved"
        $is_saved = true
    end

    puts ""
    puts 'Do you want to continue the game? Yes or No?'
    continue = gets.chomp.downcase
    
    if continue == 'yes'
        $is_saved = false
    end
end

def game_start
    instructions = [
    "",
    "Welcome to the Hangman Game!", '~~~~~~~~~~~~~~~~~~~~~~~~~~~~', 
    "Options", "1: Enter 'new' if you would like to start a new game", 
    "2: Enter 'open' if you would like to open a previous game session",
    '~~~~~~~~~~~~~~~~~~~~~~~~~~~~',
    ]

    instructions.each {|instruction| puts instruction}
    $chosen_word = generate_random_word
    $random_word = $chosen_word.split("")
    $incorrect_guesses = 6
    $blank_letters = ""
    $is_saved = false

    game_options
end

def game_logic
    until $is_saved == true || $blank_letters.include?("_") == false 
        if $incorrect_guesses == 0 
            puts ""
            puts "Game over! You ran out of guesses. The word was #{$chosen_word}."
            puts "Would you like to play again? Yes or no?"
            try_again = gets.chomp.downcase

            if try_again == 'yes'
                game_start
            end
            return

        elsif
            puts blanks_replacement.join(" ")
        end
    end
end

def game_options
    option = gets.chomp.downcase
    if option == 'new'
        puts "Here is your random word: "
        puts blanks_setup
        counter = 1
        game_logic

    elsif option == 'open'
        puts 'Enter the name of the saved filed you want to continue'
        saved_file = gets.chomp.downcase

        if File.exists?("#{saved_file}.txt")
            open_game(saved_file)
            game_logic
        else
            puts 'The file name does not exist. Returning to menu...'
            game_start
        end
    else 
        puts "Please pick one of the options above"
        game_options
    end
end

def open_game saved_file
    saved = File.read "#{saved_file}.txt"
    contents = saved.split("-")
    $blank_letters = contents[0]
    $random_word = contents[1]
    $chosen_word = contents[2]
    $incorrect_guesses = contents[3].to_i

    puts $blank_letters.split("").join(" ")
end

game_start

