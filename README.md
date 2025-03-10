# mastermind
ODIN mastermind chapter
# Mastermind (Ruby Version)

## Description
Mastermind is a classic code-breaking game where one player creates a secret code, and the other tries to guess it. This Ruby implementation allows the player to either:

1. **Guess** a secret code generated by the computer.
2. **Create** a secret code and let the computer guess it using an algorithm.

The game provides feedback after each guess using black and white pegs:
- **Black Peg**: Correct color in the correct position.
- **White Peg**: Correct color in the wrong position.

The game ends when the code is cracked or after 12 attempts.

## Features
- The game prompts the **player to enter their name**.
- Choose between **GUESS Mode** (player guesses) or **CREATE Mode** (computer guesses).
- Computer generates random codes or systematically cracks the player’s code.
- Simple text-based interface.
- Feedback system to guide the guessing process.
- Win/loss declaration after 12 attempts.

## Rules
1. The code consists of **4 pegs**, chosen from six colors: **Red, Blue, Green, Yellow, Orange, Purple**.
2. The player has **12 attempts** to guess the code correctly.
3. Players and the computer give their guesses using the **first letter of each color** (e.g., `RYBG` for Red, Yellow, Blue, Green).
4. Feedback pegs:
   - **Black Peg**: Right color, right position.
   - **White Peg**: Right color, wrong position.
5. The order of feedback pegs does not indicate the positions of correct colors.
6. If the code is not guessed in **12 turns**, the other player wins.

## How to Play
### **GUESS Mode (Player guesses the computer's code)**
1. The computer generates a **random 4-color code**.
2. The player enters a guess using **initials of colors** (e.g., `RYBG`).
3. The program provides feedback pegs.
4. Repeat until the player wins or reaches 12 attempts.

### **CREATE Mode (Computer guesses the player's code)**
1. The player sets a **4-color secret code** using initials (e.g., `GBRO`).
2. The computer makes an initial guess.
3. The player provides feedback (black and white pegs).
4. The computer refines its guesses using logic.
5. The game continues until the computer cracks the code or reaches 12 attempts.

### **Computer's Guessing Algorithm**
The computer uses a **systematic elimination strategy** based on feedback:
1. It starts with a predefined initial guess (e.g., `RRGB`).
2. After receiving feedback, it filters out impossible codes based on:
   - Number of correct colors.
   - Correct positions.
   - Incorrect colors.
3. It generates a refined guess from the remaining possible codes.
4. The process repeats until the code is cracked or attempts run out.

A more advanced version could implement **Knuth’s Five-Guess Algorithm**, which minimizes the worst-case number of turns to solve the code efficiently.

## Installation & Running the Game
1. Ensure you have **Ruby installed** (Ruby 3.0+ recommended).
2. Clone this repository:
   ```sh
   git clone https://github.com/yourusername/mastermind-ruby.git
   cd mastermind-ruby
   ```
3. Run the game:
   ```sh
   ruby mastermind.rb
   ```

## Future Enhancements
- Implement a GUI version using Ruby/Tk or Ruby on Rails.
- Add a difficulty setting (e.g., allow duplicate colors in the code).
- Improve the AI algorithm for better guessing efficiency.

## License
This project is open-source and available under the MIT License.


