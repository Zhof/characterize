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
