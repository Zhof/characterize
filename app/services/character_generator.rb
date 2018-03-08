class CharacterGenerator

  def initialize(depth)
    raise if depth == 1
    @path = Rails.root.to_s + "/db/DND_text_library.txt"
    @file = File.read(@path)
    @text = PragmaticTokenizer::Tokenizer.new(clean: true, classic_filter: true, punctuation: :none).tokenize(@file).join(" ")
    @ngrams = Ngram.new(@text).compute_nth_gram(depth)
  end

  def fetch_possibilities(word: nil)
    if word == nil
      word = @ngrams.keys.sample
    end

    words = word_options(@ngrams, word, 1)

    if words.length < 10
      limit = 9 - words.length
      shuffled_frequent_words[0..(limit / 2)].each { |w| words << w[0] }
      limit = 9 - words.length
      @ngrams.keys.sample(limit).each { |w| words << w }
    end

    words << "."
    words << "!"
    words << "?"

    return words # return array of next word choices
  end

  def shuffled_frequent_words
    word_frequencies[0..24].sample(10)
  end

  def generate_sentence(word_count: nil)
    if word_count == nil
      word_count = 10
    end
    ngrams = @ngrams.clone
    sentence = []
    curr_word = @ngrams.keys.sample
    sentence << curr_word

    word_count.times do
      options = word_options(ngrams, curr_word, 1)
      if options[0]
        next_word = options[0]
        ngrams[curr_word][next_word] -= 1

        curr_word = options[0]
        sentence << curr_word
      else
        break
      end
    end

    sentence.join(" ") + '.'
  end

  private

  def word_options(word_chain, word, threshold)
    # Return most probable words to show up after the word given
    return [] if not word_chain.keys.include?(word)

    options = []

    word_chain[word].each do |key, value|
      options << key if value >= threshold
    end
    options.sort
    return options[0..4]
  end

  def word_frequencies
    words = @text.split(' ')
    word_frequency = Hash.new(0)
    words.each { |word| word_frequency[word.downcase] += 1 }
    word_frequency.sort_by {|x,y| [-y, x]}
  end
end
