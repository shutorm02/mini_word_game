# frozen_string_literal: true

# 単語ゲーム用のクラス
class WordGame
  WORD_LIST = %w[dog
                 cat
                 rabbit
                 tiger
                 raccoon
                 cow
                 bear
                 whale
                 boar
                 horse
                 hippopotamus
                 chinchilla].freeze

  DEFAULT_LIFE = 5

  attr_accessor :remaining_life, :displayed_word, :input_chars
  attr_reader :answer_word

  def initialize(answer_word = WORD_LIST.sample)
    @answer_word = answer_word
    @displayed_word = '_' * answer_word.size
    @remaining_life = DEFAULT_LIFE
    @input_chars = []

    display_welcome_msg
  end

  def correct_char?(char)
    !!char.match?(/\A[a-zA-Z]\z/)
  end

  def already_input_char?(char)
    input_chars.include?(char)
  end

  def char_not_in_answer?(char)
    !answer_word.include?(char)
  end

  def open_answer_word
    formatted_chars = @input_chars.map { |char| "^#{char}" }.join('|')
    @displayed_word = @answer_word.tr(formatted_chars, '_')
  end

  def process_char_input(char)
    char = char.downcase
    if char_not_in_answer?(char) || already_input_char?(char)
      @remaining_life -= 1
      false
    else
      @input_chars.push(char)
      open_answer_word
      true
    end
  end

  def complete?
    displayed_word == answer_word
  end

  def display_status
    puts <<~TEXT
      --------------------
      問題：#{@displayed_word}
      残り失敗可能数：#{@remaining_life}
      --------------------
    TEXT
  end

  def display_ending_msg
    puts '--------------------------------'
    puts complete? ? 'おめでとうございます、ゲームをクリアしました！' : '残念、ゲームチャレンジ失敗です'
    puts "正解は「#{@answer_word}」でした"
  end

  private

  def display_welcome_msg
    puts <<~TEXT
      --------------------------------
      単語当てゲームへようこそ！
      アルファベットを入力し、制限回数までに「_」で隠された単語を当ててください
    TEXT
  end
end
