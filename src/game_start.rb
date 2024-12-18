# frozen_string_literal: true

require_relative './lib/word_game'

word_game = WordGame.new
word_game.display_welcome_msg

while word_game.remaining_life.positive?
  word_game.display_status

  input_char = gets.chomp
  unless word_game.correct_char?(input_char)
    puts '入力できるのはアルファベットの大文字または小文字の1文字のみです'
    next
  end

  if word_game.process_char_input(input_char)
    puts '正解です！'
    break if word_game.complete?
  else
    puts '残念！このアルファベットではないようです'
  end
end

word_game.display_ending_msg
