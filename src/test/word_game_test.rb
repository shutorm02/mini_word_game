require 'minitest/autorun'
require 'minitest/rails'
require_relative '../lib/word_game'

class WordGameTest < ActiveSupport::TestCase
  def setup
    @game = WordGame.new('dog')
  end

  def test_answer_word_is_selected_at_random_in_word_list
    game = WordGame.new
    assert_includes WordGame::WORD_LIST, game.answer_word, 'answer_word の単語は WORD_LIST に含まれていません'
  end

  def test_answer_word_can_be_specified
    assert_equal 'dog', @game.answer_word, 'answer_word が引数で指定した単語と一致しません'
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

  def test_allow_valid_character_input
    assert @game.correct_char?('a'), '小文字のアルファベット「a」の入力が制限されています'
    assert @game.correct_char?('A'), '大文字のアルファベット「A」の入力が制限されています'
  end

  def test_do_not_allow_invalid_character_input
    assert_not @game.correct_char?('1'), '数字の入力が制限されていません'
    assert_not @game.correct_char?('@'), '記号の入力が制限されていません'
    assert_not @game.correct_char?('string'), '1文字以上の英字の入力が制限されていません'
    assert_not @game.correct_char?(''), '空文字の入力が制限されていません'
  end

  def test_already_input_char?
    @game.input_chars = ['a', 'b']
    assert @game.already_input_char?('a'), '入力済みの値が「未入力」と判定されています'
    assert_not @game.already_input_char?('c'), '未入力の値が「入力済」と判定されています'
  end

  def test_char_not_in_answer?
    assert_not @game.char_not_in_answer?('d'), '解答に含まれるアルファベットが「解答に含まれない」と判定されています'
    assert @game.char_not_in_answer?('c'), '解答に含まれないアルファベットが「解答に含まれる」と判定されています'
  end

  def test_open_answer_word_with_no_same_characters
    @game.input_chars = ['d', 'o']
    @game.open_answer_word
    assert_equal 'do_', @game.displayed_word, 'input_chars に存在するアルファベットが displayed_word から開放されていません'
  end
  
  def test_open_answer_word_with_same_characters
    game = WordGame.new('rabbit')
    game.input_chars = ['r', 'b']
    game.open_answer_word
    assert_equal 'r_bb__', game.displayed_word, 'input_chars に存在するアルファベットが displayed_word から開放されていません'
  end

  def test_process_char_with_input_correct
    assert @game.process_char_input('d'), '解答に含まれる入力値が「解答に含まれない」と判定されています'
    assert_equal 'd__', @game.displayed_word, '解答に含まれる入力値が displayed_word から開放されていません'
    assert_equal WordGame::DEFAULT_LIFE, @game.remaining_life, '解答に含まれる入力値を入力後、remaining_life の値が変化しています'
    assert_includes @game.input_chars, 'd', '解答に含まれる入力値が input_chars に追加されていません'
  end

  def test_process_char_with_input_incorrect
    assert_not @game.process_char_input('c'), '解答に含まれない入力値が「解答に含まれる」と判定されています'
    assert_equal '___', @game.displayed_word, '解答に含まれない入力値が displayed_word から開放されています'
    assert_equal WordGame::DEFAULT_LIFE - 1, @game.remaining_life, '解答に含まれない入力値を入力後、remaining_life の値が -1 されていません'
    assert_not_includes @game.input_chars, 'c', '解答に含まれない入力値が input_chars に追加されています'
  end
  
  def test_process_char_with_input_already_input
    @game.input_chars = ['d']
    assert_not @game.process_char_input('d'), 'input_chars に存在する入力値が「解答に含まれる」と判定されています'
    assert_equal WordGame::DEFAULT_LIFE - 1, @game.remaining_life, 'input_chars に存在する入力値を入力後、remaining_life の値が -1 されていません'
  end

  def test_complete?
    assert_not @game.complete?, 'display_word が answer_word と一致しない状態で「ゲームクリア」と判定されました'
    @game.displayed_word = 'dog'
    assert @game.complete?, 'display_word が answer_word と一致する状態で「ゲームクリア」と判定されていません'
  end
end
