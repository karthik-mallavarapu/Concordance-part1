
class Concordance

  # Regular expression constants 
  SENTENCE_DELIMITER = /\. [A-Z]/
  WORD_SANITIZE = /\A[-,:;*^()\/&%{}$!@#=\"'?\”\“]+|[-,:;*^()\/&%{}$!@#=\"'?\”\“]+\z/
  DOT_SANITIZE = /\A[\.]+|[\.]+\z/

  # Constructor accepts text as a parameter and prints the result according to the given format.
  def initialize(text)
    @text = text
    @sentences = []
    @result = {}
    @text.gsub!("\n", '')
    get_sentences
    get_words
    print_concordance
  end

  # Extract sentences out of the text, by searching for a pattern of white 
  # space, period and a capital letter.
  def get_sentences
    # Get initial letters of sentences.
    initial_letters = @text.scan(SENTENCE_DELIMITER).map {|i| i[-1]}
    # Get sentences by splitting text with the pattern. 
    # Sentences from index 1 to end are without initial letters.
    @sentences = @text.split(SENTENCE_DELIMITER)
    # Add the initial letters back to the sentences.
    (1...@sentences.length).each do |i|
      @sentences[i] = initial_letters[i - 1] + @sentences[i]
    end
  end

  # Iterate through all the words from all the sentences.
  def get_words
    @sentences.each_index do |i|
      s = @sentences[i]
      words = s.split(' ')
      words.each do |w|
        word = w.gsub(WORD_SANITIZE, '').downcase
        if belongs_to_known_abbreviations? word
          add_word_to_result(word, i)
        else
          add_word_to_result(word.gsub(DOT_SANITIZE, ''), i)
        end
      end
    end
  end

  # Prints the word frequencies and occurrences in the format specified.
  def print_concordance
    puts "\n\nPrinting concordance...\n\n"
    sorted_keys = @result.keys.sort
    sorted_keys.each do |key|
      puts "#{key.ljust(20)} {#{@result[key][:count]}:#{@result[key][:line_nums].join(',')}}"
    end
  end

  private

  # Certain abbreviations like e.g. are filtered away while sanitizing the word
  # to remove punctuations like comma, exclamation mark, quotes etc.
  def belongs_to_known_abbreviations? (word)
    abbreviations = [
      'a.d.', 'a.i.', 'a.m.', 'ca.', 'cap.',
      'cf.', 'cp.', 'c.v.', 'cwt.', 'd.v.',
      'd.g.', 'ead.', 'etc.', 'e.g.', 'i.e.',
      'i.a.', 'lib.', 'j.d.', 'lb.', 'll.b.',
      'm.a.', 'm.o.', 'n.b.', 'p.a.', 'ph.d.',
      'p.m.', 'p.m.a', 'p.p', 'p.s.', 'q.d.', 
      'q.e.d', 'q.v.', 'r.', 'r.i.p', 's.o.s', 
      'sic.', 'stat.', 'viz.' ]
    return abbreviations.include? word
  end

  # Add the word to the result hash.
  def add_word_to_result(word, line_num)
    return if word == ''
    if @result[word].nil?
      h = Hash.new
      h[:count] = 1
      h[:line_nums] = [line_num]
      @result[word] = h
    else
      @result[word][:count] += 1
      @result[word][:line_nums] << line_num
    end
  end

end
