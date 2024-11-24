require 'minitest/autorun'
require_relative '../lib/word_game'

class WordGameTest < Minitest::Test
  def setup
    @game = WordGame.new
  end

  def test_answer_word_is_selected_at_random_in_word_list
    assert_includes WordGame::WORD_LIST, @game.answer_word, 'answer_word の単語は WORD_LIST に含まれていません'
  end

  def test_answer_word_can_be_specified
    game = WordGame.new('dog')
    assert_equal 'dog', game.answer_word, 'answer_word が引数で指定した単語と一致しません'
  end

  def test_initial_displayed_word_and_answer_word_and_is_same_size
    assert_equal @game.displayed_word.size, @game.answer_word.size, 'displayed_word の初期値と answer_word の文字数が一致しません'
  end

  def test_initial_displayed_word_contains_only_underscore
    assert_match /\A_*\z/, @game.displayed_word, 'displayed_word の初期値に「_」以外が含まれています'
  end

  def test_initial_remaining_life_is_same_as_default_life
    assert_equal @game.remaining_life, WordGame::DEFAULT_LIFE, 'remaining_life の初期値がデフォルト値と一致しません'
  end
  
  def test_initial_input_chars_is_empty
    assert_predicate @game.input_chars, :empty?, 'input_chars の初期値にすでに値が存在します'
  end
  
end
