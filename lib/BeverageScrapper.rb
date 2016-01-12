require "BeverageScrapper/version"
require "sentence"

module BeverageScrapper
  class Wordbins
    #words concerning money
   def self.money
     %w(money cash coins cost dollars cents price prices expensive cheap tax)
   end
   #list of strings of softdrink brands
    def self.brands
      %w(coke sprite pepsi dr.pepper drpepper cocacola cokezero mountaindew minutemaid fanta pepsi-cola a&w 7up mug cola dasani)
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
  end
  class Classify
    #using bayes, determines if sentence is about beverages
    def self.aboutbeverages(text)
      brands = BeverageScrapper::Wordbins.brands
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
  end
end
