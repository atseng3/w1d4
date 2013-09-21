require 'set'
require 'debugger'
class WordChains
  attr_accessor :dictionary

  def initialize(dictionaryfile)
    # @dictionaryfile = dictionaryfile
    @dictionary = File.readlines(dictionaryfile).map(&:chomp)

  end

  def find_chain(start_word, end_word, dictionary)
    current_words = Set.new [start_word]
    new_words = Set.new []
    visited_words = {start_word => nil}
    @dictionary.select! { |dict_word| dict_word.length == start_word.length}

    until over?(new_words, end_word)
      current_words.each do |word_right_now|
        new_words.merge(adjacent_words(word_right_now, @dictionary).to_set)#.over?
        new_words.delete(word_right_now)
        debugger
        new_words.each do |new_word|
          visited_words[new_word] = word_right_now #unless visited_words.include?(word_right_now)
        end
      end
      current_words = new_words
      new_words = Set.new []
    end
      # build_chain(visited_words, end_word)
  end

  def adjacent_words(word, dictionary)
    chosen_words = []
    (0...word.length).each do |index|
      word2 = word.dup
      word2[index] = "[a-z]"
      chosen_words  += dictionary.select { |dict_word|  !dict_word.match(/#{word2}/).nil? }
    end
    chosen_words
  end

  def build_chain(visited_words, end_word)

  end

  def over?(new_words, end_word)
    true if new_words.include?(end_word)
  end

end

wc = WordChains.new('dictionary.txt')
p wc.find_chain('hi', 'it', wc.dictionary)
