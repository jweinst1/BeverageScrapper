require "BeverageScrapper/version"

module BeverageScrapper
  class Wordbins
    #words concerning money
   def self.money
     %w(money cash coins cost dollars cents price prices expensive cheap tax)
   end
   #list of strings of softdrink brands
    def self.brands
      %w(coke sprite pepsi dr.pepper drpepper cocacola cokezero mountaindew minutemaid)
    end
  end
end
