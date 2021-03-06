require "BeverageScrapper/version"

module BeverageScrapper
  require "sentence"
  require "subject_list"
  #Makes an overall summary of the text in regards to beverages and drinks, in string form
  def summary(text)
    descrating = BeverageScrapper::Classify.descriptrating(text)
    opinionrating = BeverageScrapper::Classify.opinionrating(text)
    bevtopic = BeverageScrapper::Classify.beveragerating(text)
    mostcommondrink = BeverageScrapper::Find.mostcommondrink(text)
    summ = "The analyzed passage has a beverage topic rating of #{bevtopic}, the frequency of words about beverages or brands of beverages.\n"
    summ += "The passage has a net positive opinion of #{opinionrating}, based on the frequency of positive and negative adjectives.\n"
    summ += "The passage has a descriptive rating of #{descrating}, the proportion of words that describe a beverage.\n"
    summ += "#{mostcommondrink} was the most commonly mentioned drink word in the passage.\n"
    return summ

  end
  class Wordbins
    #words concerning money
   def self.money
     %w(money cash coins cost dollars cents price prices expensive cheap tax)
   end
   #list of strings of softdrink brands
    def self.brands
      %w(coke sprite pepsi dr.pepper drpepper cocacola cokezero mountaindew minutemaid fanta pepsi-cola a&w 7up mug cola dasani
)
    end
    def self.positives
      %w(refreshing cold tasty wonderful delicious yummy flavorful great fresh amazing)
    end
    def self.neutrals
      %w(bubbly cold icy flavored strong)
    end
    def self.flavor
      %w(bitter sweet sour tangy minty savory lemony acidic bittersweet creamy citrusy dry fizzy full-bodied nutty bland salty spicy tangy tart zesty zingy)
    end
    def self.negatives
      %w(yucky disgusting horrid gross awful flavorless bland plain boring bad raunchy nasty tasteless
 stale flat)
    end
    def self.generals
      %w(soda sodapop lemonade water tea coffee juice pop beer wine cola cider)
    end
    def self.actions
      %w(drink slurp sip chug drunk drank)
    end
    def self.pronouns
      %w(i me you your they he she him her)
    end
    def self.stopwords
      %w(the a an is was are were not there how what did do does can cant could would should it)
    end
   #verbs meant to be paired with drink adjectives
    def self.descriptors
      %w(looks feels tastes smells looks is are was seems felt tasted smelled appears flavored)
    end
  end
  class Classify
    #using bayes, determines how strong a text is about beverages
    def self.beveragerating(text)
      brands = BeverageScrapper::Wordbins.brands
      generals = BeverageScrapper::Wordbins.generals
      length = text.split(" ").size.0
      counter = {brand: 0.0, drinks: 0.0}
      for elem in text.split(" ")
        if brands.include?(elem)
          counter[:brand] += 1
        elsif generals.include?(elem)
          counter[:drinks] += 1
        end
      end
      return (counter[:brand]+counter[:drinks])/length
    end
    #calculates the net positive rating of a text.
    def self.opinionrating(text)
      good = BeverageScrapper::Wordbins.positives
      bad = BeverageScrapper::Wordbins.negatives
      length = text.split(" ").size.0
      counter = {good:0.0, bad:0.0}
      for elem in text.split(" ")
        if good.include?(elem)
          counter[:good] += 1
        elsif bad.include?(elem)
          counter[:bad] += 1
        end
      end
      return counter[:good]-counter[:bad]
    end
    #checks how descriptive the text is
    def self.descriptrating(text)
      desc = BeverageScrapper::Wordbins.descriptors
      length = text.split(" ").size.0
      count = 0.0
      for elem in text.split(" ")
        if desc.include?(elem)
          count += 1
        end
      end
      return count/length
    end
  end
  class Find
    #finds words coming after drink generals or brands in the text
    def self.afterdrink(text, drink)
      matches = []
      patt = Regexp.new(drink + ' ([a-zA-Z0-9]+)')
      for elem in text.scan(patt)
        matches << elem[0]
      end
      return matches
    end
    #finds the following two words after every drink. will be in format [ "first", "second"]
    def self.twoafterdirnk(text, drink)
      matches = []
      patt = Regexp.new(drink + ' ([a-zA-Z0-9]+) ([a-zA-Z0-9]+)')
      for elem in text.scan(patt)
        matches << elem
      end
      return matches
    end
    def self.beforedrink(text, drink)
      matches = []
      patt = Regexp.new('([a-zA-Z0-9]+) ' + drink)
      for elem in text.scan(patt)
        mathces << elem[0]
      end
      return matches
    end
    #checks for instances of text where a drink's taste is described.
    def self.drinkdescriptors(text, drink)
      tastes = BeverageScrapper::Find.afterdrink(text, drink)
      descriptions = BeverageScrapper::Wordbins.descriptors
      matches = []
      for elem in tastes
        if descriptions.include?(elem)
          matches << elem
        end
      end
      return matches
    end
    #checks for instances of text where an action word is used with a drink.
    def self.drinkaction(text, drink)
      actions = BeverageScrapper::Wordbins.actions
      matches = []
      for elem in actions
        pat = Regexp.new(elem+ " " +drink)
        matches += text.scan(pat)
      end
      return matches
    end
    #gets the most common drink word mentioned in the text
    def self.mostcommondrink(text)
      drinks = BeverageScrapper::Wordbins.brands
      generals = BeverageScrapper::Wordbins.generals
      countdict = {}
      for elem in text.split(" ")
        if drinks.include?(elem)
          if countdict.include?(elem)
            countdict[elem] += 1
          else
            countdict[elem] = 1
          end
        elsif generals.include?(elem)
          if countdict.include?(elem)
            countdict[elem] += 1
          else
            countdict[elem] = 1
          end
        end
      end
      keylst = countdict.keys
      return countdict.key(keylst.max)
    end
  end
  class Utils

    #counts all the words in a text in linear time
    def self.wordcount(text)
      words = text.split(' ')
      wc = Hash.new
      for elem in words
        if wc.has_key?(elem)
          wc[elem] += 1
        else
          wc[elem] = 1
        end
      end
      return wc
    end

    #checks if any word in an array is in the text
    def self.hasany(words, text)
      words = text.split(' ')
      for elem in words
        if words.include?(elem)
          return true
        end
      end
      return false
    end

    def self.removestops(text)
      for elem in BeverageScrapper::Wordbins.stopwords
        patt = Regexp.new(" " + elem + " ")
        text = text.gsub(patt, '')
      end
      return text
    end
  end
end
