require_relative './lib/word_game'

word_game = WordGame.new

while word_game.remaining_life > -1
  input_chars = gets.chomp

  if !word_game.correct_chars?(input_chars)
    puts '入力できるのはアルファベットの大文字または小文字の1文字のみです'
    next
  end
end
