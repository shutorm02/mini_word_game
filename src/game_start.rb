require_relative './lib/word_game'

word_game = WordGame.new

while word_game.remaining_life > -1
  input_char = gets.chomp

  if !word_game.correct_char?(input_char)
    puts '入力できるのはアルファベットの大文字または小文字の1文字のみです'
    next
  end

  if word_game.check_char_whether_exist_in_the_answer(input_char)
    puts '正解です！'
    break if word_game.correct_answer?
  else
    puts '残念！このアルファベットではないようです'
  end
end
