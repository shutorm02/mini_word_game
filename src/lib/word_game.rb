class WordGame

  WORD_LIST = %w[dog cat rabbit
    tiger
    raccoon
    cow
    bear
    whale
    boar
    horse
    hippopotamus
    chinchilla
  ].freeze

  DEFAULT_REMAINING_LIFE = 5

  attr_accessor :remaining_life, :displayed_word, :input_chars
  attr_reader :answer_word

  def initialize(answer_word = WORD_LIST.sample)
    @answer_word = answer_word
    @displayed_word = create_initial_word(@answer_word.size)
    @remaining_life = DEFAULT_REMAINING_LIFE
    @input_chars = []

    display_welcome_msg
  end

  def correct_char?(char)
    !!char.match(/[a-zA-Z]/) && char.size == 1
  end

  def is_already_input_char?(char)
    @input_chars.include?(char)
  end

  def not_exist_char_in_the_answer?(char)
    !@answer_word.include?(char)
  end

  def open_answer_word
    formatted_chars = @input_chars.map { |char| "^#{char}" }.join('|')
    @displayed_word = @answer_word.tr(formatted_chars, "_")
  end

  def check_char_whether_exist_in_the_answer(char)
    char = char.downcase

    if not_exist_char_in_the_answer?(char) || is_already_input_char?(char)
      @remaining_life -= 1
      false
    else
      @input_chars.push(char)
      open_answer_word
      true
    end
  end

  def complete?
    @displayed_word == @answer_word
  end

  def display_status
    puts <<-EOT
--------------------
問題：#{@displayed_word}
残り制限回数：#{@remaining_life}
--------------------
    EOT
  end

  def display_ending_msg
    puts '--------------------------------'
    puts complete? ? 'おめでとうございます、ゲームをクリアしました！' : '残念、ゲームチャレンジ失敗です'
    puts "正解は「#{@answer_word}」でした"
  end

  private

  def create_initial_word(word_length)
    initial_word = ''
    word_length.times {
      initial_word << '_'
    }
    return initial_word
  end

  def display_welcome_msg
    puts <<-EOT
--------------------------------
単語当てゲームへようこそ！
アルファベットを入力し、制限回数までに「_」で隠された単語を当ててください
    EOT
  end
end
