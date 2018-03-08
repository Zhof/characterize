require 'json'
require 'pragmatic_tokenizer'
require 'open-uri'

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

class Generator

  def initialize(file, depth)
    @file = file
    @text = PragmaticTokenizer::Tokenizer.new(clean: true, classic_filter: true, punctuation: :none).tokenize(file).join(" ")
    @ngrams = Ngram.new(@text).compute_nth_gram(depth)
  end

  def fetch_possibilities(word: nil)
    if word == nil
      word = @ngrams.keys.sample
    end

    words = word_options(@ngrams, word, 1)

    if words.length < 5
      limit = 5 - words.length
      shuffled_frequent_words[0..limit].each { |w| words << w[0] }
    end

    words << "."
    words << "!"
    words << "?"

    return words # return array of next word choices
  end

  def shuffled_frequent_words
    word_frequencies[0..20].sample(5)
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

    return options[0..5]
  end

  def word_frequencies
    words = @text.split(' ')
    word_frequency = Hash.new(0)
    words.each { |word| word_frequency[word.downcase] += 1 }
    word_frequency.sort_by {|x,y| [-y, x]}
  end
end
