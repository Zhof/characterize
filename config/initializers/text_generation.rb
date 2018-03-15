class Ngram
  attr_accessor :options

  def initialize(target)
    @target = target
    @options = options
    @ngram_frequencies = Hash.new { |word, follow_word| word[follow_word] = Hash.new(0) }
  end

  def ngrams(n)
    @target.split(' ').each_cons(n).to_a
  end

  def compute_nth_gram(n)
    ngram_frequencies = @ngram_frequencies.clone

    ngrams(n).each do |gram|
      first_key = (n - 1).times.map { |i| gram[i].downcase }.join(' ')
      ngram_frequencies[first_key][gram[n - 1].downcase] += 1
    end

    ngram_frequencies
  end

end

class CharacterGenerator
  attr_accessor :path, :file, :text, :ngrams, :word_choices, :stop_words
  def initialize(depth)
    raise if depth == 1
    @path = Rails.root.to_s + "/db/DND_text_library.txt"
    @file = File.read(@path)
    @text = PragmaticTokenizer::Tokenizer.new(clean: true, classic_filter: true, punctuation: :none).tokenize(@file).join(" ")
    @ngrams = Ngram.new(@text).compute_nth_gram(depth)
    @word_choices = {}
    @stop_words = File.read(Rails.root.to_s + "/db/stop_words.txt").split("\n")
    @ngrams.each do |key, value|
      @word_choices[key] = word_options(@ngrams, key).flatten
    end
    @word_frequencies = word_frequencies
  end

  def fetch_possibilities(word: nil)
    if word == nil || word == "." || word == ","
      word = @word_choices.keys.sample
    else
      word = word.downcase
    end

    words = @word_choices[word][0..15].sample(10).shuffle

    if words.length < 20
      limit = 19 - words.length
      shuffled_frequent_words[0..(limit / 2)].each { |w| words << w[0] }
      limit = 19 - words.length
      @word_choices.keys.sample(limit).each { |w| words << w }
    end

    words << "."

    return words # return array of next word choices
  end

  def shuffled_frequent_words
    @word_frequencies[0..19].sample(8)
  end

  def generate_sentence(word_count: nil, word: nil)
    ngrams = @ngrams.clone
    sentence = []

    if word_count == nil
      word_count = (8..20).to_a.sample
    end
    if word == nil || word == ""
      curr_word = shuffled_frequent_words.sample[0]
      sentence << curr_word
    else
      curr_word = word
    end

    word_count.times do
      options = word_options(ngrams, curr_word)
      options.each do |word|
        if stop_word?(word)
          options.delete(word)
        end
      end
      if options[0] && options[1] && options[2]
        next_word = options[0..3].sample
        ngrams[curr_word][next_word] -= 1
        curr_word = next_word
        sentence << curr_word
      else
        curr_word = shuffled_frequent_words.sample[0]
        sentence << curr_word
      end
    end
    sentence.join(" ")
  end

  private

  def stop_word?(word)
    @stop_words.include?(word)
  end

  def word_options(word_chain, word)
    # Return most probable words to show up after the word given
    return [] if not word_chain.keys.include?(word)

    options = []

    options << word_chain[word].sort_by {|key, value| -value}.map(&:first)
    options.flatten!
    return options
  end

  def word_frequencies
    words = @text.split(' ')
    word_frequency = Hash.new(0)
    words.each do |word|
      if stop_word?(word)
        words.delete(word)
      else
        word_frequency[word.downcase] += 1
      end
    end
    word_frequency.sort_by {|x,y| [-y, x]}
  end
end


Generator = CharacterGenerator.new(2)
