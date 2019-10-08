def generate_random_word 
    words = File.read "5desk.txt"
    word = words.split(" ")

    random = rand(word.length + 1)
    word[random]
end

$random_word = generate_random_word.split("")
$incorrect_guesses = 3
$blank_letters = ""

def setup
    counter = 0
    
    
    while counter < $random_word.length
        $blank_letters += "_"
        counter += 1
    end
    
    puts $blank_letters.split("").join(" ")
end

def blanks

    puts ""
    puts 'Please guess a letter in the word'
    guess_letter = gets.chomp


    if $random_word.include?(guess_letter)
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


puts 'Welcome to the Hangman Game!'
puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
puts 'Here is your random word: '
puts setup
counter = 1

until $blank_letters.include?("_") == false
    if $incorrect_guesses == 0 
        puts "Sorry, you ran out of guesses! Please try again"
        return
    else
        puts blanks.join(" ")
    end
end

