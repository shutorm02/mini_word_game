class WordGame

  WORD_LIST = ['dog', 'cat', 'rabbit', 'tiger', 'raccoon', 'cow', 'bear', 'whale']
  DEFAULT_REMAINING_LIFE = 5

  attr_accessor :remaining_life, :displayed_word
  attr_reader :answer_word

  def initialize()
    @answer_word = WORD_LIST.sample
    @displayed_word = create_initial_word(@answer_word.size)
    @remaining_life = DEFAULT_REMAINING_LIFE

    puts <<-EOT
--------------------------------
単語当てゲームへようこそ！
アルファベットを入力し、制限回数までに「_」で隠された単語を当ててください
--------------------
残り制限回数：#{@remaining_life}
問題：#{@displayed_word}
--------------------
    EOT
  end

  def correct_chars?(chars)
    !!chars.match(/[a-zA-Z]/) && chars.size == 1
  end

  private

  def create_initial_word(word_length)
    initial_word = ''
    word_length.times {
      initial_word << '_'
    }
    return initial_word
  end
end
