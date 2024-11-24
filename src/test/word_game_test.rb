require 'minitest/autorun'
require 'minitest/rails'
require_relative '../lib/word_game'

class WordGameTest < ActiveSupport::TestCase
  def setup
    @game = WordGame.new('dog')
  end

  def test_initialize_with_random_answer_word
    game = WordGame.new
    assert_includes WordGame::WORD_LIST, game.answer_word
  end

  def test_initialize_with_specific_answer_word
    assert_equal 'dog', @game.answer_word
  end

  def test_displayed_word_and_answer_word_have_same_length
    assert_equal @game.displayed_word.size, @game.answer_word.size
  end

  def test_displayed_word_initially_contains_only_underscores
    assert_match(/\A_*\z/, @game.displayed_word)
  end

  def test_remaining_life_initial_value
    assert_equal WordGame::DEFAULT_LIFE, @game.remaining_life
  end
  
  def test_input_chars_initial_value
    assert_empty @game.input_chars
  end

  def test_correct_char
    assert @game.correct_char?('a')
    assert @game.correct_char?('A')
    assert_not @game.correct_char?('1')
    assert_not @game.correct_char?('@')
    assert_not @game.correct_char?('string')
    assert_not @game.correct_char?('')
  end

  def test_already_input_char
    @game.input_chars = %w[a b]
    assert @game.already_input_char?('a')
    assert_not @game.already_input_char?('c')
  end

  def test_char_not_in_answer
    assert_not @game.char_not_in_answer?('d')
    assert @game.char_not_in_answer?('c')
  end

  def test_open_answer_word
    @game.input_chars = %w[d o]
    @game.open_answer_word
    assert_equal 'do_', @game.displayed_word
  end
  
  def test_open_answer_word_with_same_characters
    game = WordGame.new('rabbit')
    game.input_chars = %w[r b]
    game.open_answer_word
    assert_equal 'r_bb__', game.displayed_word
  end

  def test_process_char_input_correct
    assert @game.process_char_input('d')
    assert_equal 'd__', @game.displayed_word
    assert_equal WordGame::DEFAULT_LIFE, @game.remaining_life
    assert_includes @game.input_chars, 'd'
  end

  def test_process_char_input_incorrect
    assert_not @game.process_char_input('c')
    assert_equal '___', @game.displayed_word
    assert_equal WordGame::DEFAULT_LIFE - 1, @game.remaining_life
    assert_not_includes @game.input_chars, 'c'
  end
  
  def test_process_char_input_already_input
    @game.input_chars = ['d']
    assert_not @game.process_char_input('d')
    assert_equal WordGame::DEFAULT_LIFE - 1, @game.remaining_life
  end

  def test_complete?
    assert_not @game.complete?
    @game.displayed_word = 'dog'
    assert @game.complete?
  end
end
