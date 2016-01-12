#class for searching and mining sentences

class Sentence
  def initialize(text)
    @words = text.split(' ')
    @phrase = text
    @tag = nil
  end
  #words accessor
  def words
    @words
  end
  #phrase accessor
  def phrase
    @phrase
  end
  def tag
    @tag
  end
  def contains(word)
    @words.include? word
  end

  def ismatch(exp)
    @phrase =~ exp
  end

  def countmembers(words)
    count = 0
    for elem in @words
      if words.include? elem
        count += 1
      end
    end
    count
  end
  def settag(label)
    @tag = label
  end
end