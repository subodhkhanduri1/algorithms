# Aho-Corasick Algorithm
# T - Text Stream
# P - List of word Patterns to search
#
# Trie construction complexity
#   O(m), m = Total characters in all patterns
#
# Search complexity
#   O(n + z),
#     n = No of characters in the stream,
#     z = No of matches found
#
class MatchPatterns

  attr_accessor :text, :words
  attr_accessor :trie_goto, :trie_failure, :state_words

  def initialize(text, words)
    self.text = text
    self.words = words

    prepare_trie
  end

  def matches
    word_count_hash = initial_word_count
    current_state = 0
    index = 0
    text.each_char do |char|
      current_state = find_next_state(current_state, char)

      state_words[current_state].each do |word|
        word_count_hash[word] += 1
        puts index
        puts "#{word} found at index #{index - word.length + 1}"
      end

      index += 1
    end

    word_count_hash
  end

  def initial_word_count
    Hash[words.map { |word| [word, 0] }]
  end

  def find_next_state(current_state, char)
    while trie_goto[current_state][char].nil? do
      current_state = trie_failure[current_state]
    end

    trie_goto[current_state][char]
  end

  private

  def prepare_trie
    self.trie_failure = []
    self.state_words = []

    prepare_trie_goto
    prepare_trie_failure
  end

  def prepare_trie_goto
    self.trie_goto = []
    states = 0
    state_words[0] = Set.new

    words.each do |word|
      current_state = 0

      word.each_char do |char|
        trie_goto[current_state] ||= {}
        if trie_goto[current_state][char].nil?
          states += 1
          trie_goto[current_state][char] = states
          current_state = states
        else
          current_state = trie_goto[current_state][char]
        end
      end

      trie_goto[current_state] ||= {}      

      state_words[current_state] ||= Set.new
      state_words[current_state] << word
    end

    ('a'..'z').each do |char|
      next unless trie_goto[0][char].nil?

      trie_goto[0][char] = 0
    end

    states.times do |state|
      state_words[state] ||= Set.new
    end

    puts trie_goto
    puts state_words
  end

  def prepare_trie_failure
    queue = []
    trie_failure[0] = 0

    ('a'..'z').each do |char|
      if !trie_goto[0][char].zero?
        trie_failure[trie_goto[0][char]] = 0
        queue << trie_goto[0][char]
      end
    end

    while !queue.empty? do
      current_state = queue.shift
      puts "current_state: #{current_state}"
      puts "queue: #{queue}"
      # binding.pry

      ('a'..'z').each do |char|
        unless trie_goto[current_state][char].nil?
          current_failure_state = trie_failure[current_state]

          while trie_goto[current_failure_state][char].nil? do
            current_failure_state = trie_failure[current_failure_state]
          end

          trie_failure[trie_goto[current_state][char]] = trie_goto[current_failure_state][char]

          state_words[trie_goto[current_state][char]] |= state_words[trie_goto[current_failure_state][char]]

          queue << trie_goto[current_state][char]
        end
      end
    end
  end
end

m = MatchPatterns.new('sherhers', ['she', 'he', 'hers', 'his'])
