class Mastermind
  COLORS = %w[R B G Y O P] # Red, Blue, Green, Yellow, Orange, Purple
  ATTEMPTS = 12

  def initialize
    @player_name = ""
    @mode = ""
    @secret_code = []
  end

  def start
    welcome_message
    choose_mode
    play_game
  end

  private

  def welcome_message
    puts "Welcome to Mastermind! What is your name?"
    @player_name = gets.chomp.capitalize
    puts "Hello, #{@player_name}! Let's begin."
  end

  def choose_mode
    puts "Do you want to (G)UESS or (C)REATE the secret code?"
    @mode = gets.chomp.upcase
    until %w[G C].include?(@mode)
      puts "Invalid choice. Please enter 'G' to guess or 'C' to create the code."
      @mode = gets.chomp.upcase
    end
  end

  def play_game
    if @mode == "G"
      play_guess_mode
    else
      play_create_mode
    end
  end

  def play_guess_mode
    @secret_code = Array.new(4) { COLORS.sample }.join
    attempts_left = ATTEMPTS
    puts "The computer has generated a secret code. Start guessing! (Use letters like RYBG)"

    until attempts_left.zero?
      puts "Attempts left: #{attempts_left}. Enter your guess:"
      guess = get_valid_guess
      feedback = evaluate_guess(guess)
      puts "Feedback: #{feedback}"
      if feedback == "BBBB"
        puts "Congratulations #{@player_name}, you cracked the code!"
        return
      end
      attempts_left -= 1
    end
    puts "Game over! The secret code was #{@secret_code}"
  end

  def play_create_mode
    puts "Enter your secret 4-letter code using R, B, G, Y, O, P:"
    @secret_code = get_valid_guess
    attempts_left = ATTEMPTS
    possible_codes = COLORS.repeated_permutation(4).to_a.map(&:join)
    possible_colors = COLORS.dup # Track usable colors

    while attempts_left > 0 && !possible_codes.empty?
      computer_guess = possible_codes.sample
      puts "Attempts left: #{attempts_left}. Computer's guess: #{computer_guess}"
      puts "Enter feedback (e.g., 'BBWW' for 2 correct position/colors, 2 misplaced):"
      feedback = gets.chomp.upcase

      if feedback == "BBBB"
        puts "Computer cracked your code in #{ATTEMPTS - attempts_left + 1} attempts!"
        return
      elsif feedback.empty?
        # Remove colors that received no feedback, but ensure at least one remains
        colors_in_guess = computer_guess.chars.uniq
        possible_colors -= colors_in_guess
        possible_colors = COLORS.dup if possible_colors.empty? # Reset if all are removed
        possible_codes.select! { |code| code.chars.any? { |c| possible_colors.include?(c) } }
      else
        possible_codes.select! { |code| evaluate_guess(code) == feedback }
      end
      attempts_left -= 1
    end
    puts "Computer failed to crack your code! You win, #{@player_name}!"
  end

  def get_valid_guess
    guess = gets.chomp.upcase
    until valid_guess?(guess)
      puts "Invalid input. Enter exactly 4 letters using R, B, G, Y, O, P:"
      guess = gets.chomp.upcase
    end
    guess
  end

  def valid_guess?(guess)
    guess.length == 4 && guess.chars.all? { |char| COLORS.include?(char) }
  end

  def evaluate_guess(guess)
    feedback = []
    temp_code = @secret_code.dup.chars # Ensure it's an array copy
    guess_chars = guess.chars
    
    # Track used positions
    used_positions = Array.new(4, false)
    
    # Check for correct positions (Black Pegs)
    guess_chars.each_with_index do |char, index|
      if temp_code[index] == char
        feedback << "B"
        temp_code[index] = nil
        used_positions[index] = true
      end
    end
    
    # Check for correct colors in wrong positions (White Pegs)
    guess_chars.each_with_index do |char, index|
      next if used_positions[index] # Skip if already used for 'B'
      found_index = temp_code.index(char)
      if found_index && !used_positions[found_index]
        feedback << "W"
        temp_code[found_index] = nil
        used_positions[found_index] = true
      end
    end
    
    feedback.sort.join # Ensure order is not revealing positions
  end
end

# Start the game
Mastermind.new.start
