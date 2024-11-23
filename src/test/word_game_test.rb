require 'minitest/autorun'
require_relative '../lib/word_game'

class WordGameTest < Minitest::Test
  def test_answer_word_can_be_specified
    game = WordGame.new('dog')
    assert_equal 'dog', game.answer_word
  end
end
