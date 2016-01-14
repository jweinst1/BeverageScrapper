# BeverageScrapper
[Gem Page](https://rubygems.org/gems/BeverageScrapper)

BeverageScrapper is an API for data mining information about soft drinks, beverages, drinks, and other information relating to opinions and data on drinks.
The Gem features many different analysis methods, such as determining the percentage of a text being about beverages, how often a specific soft drink is mentioned, and in what context, and much more.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'BeverageScrapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install BeverageScrapper

##Documentation
BeverageScrapper provides different methods for statistically analyzing the beverage data in written text. Here is an overview of the main functions, as well as the core classes for parsing/searching passages.

####`BeverageScrapper::summary(text)`:
Returns a string containing all of the core data results from the methods of the API. These include the net positivity rating(The portion of good words minus the portion of bad or critical words), the subjectivity rating(To what degree is a text about soft drinks or beverages) and the descriptor rating(How much does a text focus on describing drinks or describing experiences related to soft drinks). In addition, it will give the most commonly mentioned drink in the passage.

###Class Wordbins
A class containing arrays of words relevant to the data mining. Examples are lists of beverage brands, types of drinks, verbs related to eating and drinking, nouns relating to purchasing and money, plus much more.

###Class Classify
A class containing methods for determining the ratio or frequency of specific groups of words in the input passage. 

####`BeverageScrapper::Classify.beveragerating(text)`:
Out of a maximum value of 1, determines the portion of words in a text that are related to softdrinks or beverages. The words targeted with this method can be brand names of drinks, or general names, like soda and lemonade.

####`BeverageScrapper::Classify.opinionrating(text)`:
Returns the difference of the total number of positive, descriptor words and negative, critical descriptor words in a passage. Uses terms more related to food and taste.

####`BeverageScrapper::Classify.descriptrating(text)`:
Out of a meximum value of 1, determines the fraction or portion of words in a text that have a describing meaning. Useful for determining if the text mentions soft drinks as a side subject, or is about describing drinks and beverages, a measure of importance.

###Class Find

A class containing methods that scan the text for specific ordering of words related to specificed subject drinks or words.

####`BeverageScrapper::Find.afterdrink(text, drink)`:

For a specific alphanumeric word, drink, finds all the words in the text occuring directly after drink. Returns an array of strings.

####`BeverageScrapper::Find.twoafterdrink(text, drink)`:
Does the same as `afterdrink` but returns an array of two element arrays of strings, where the first string in each subarray represents the first word after drink, and the second word represents the second word after drink.

####`BeverageScrapper::Find.beforedrink(text, drink)`:

For a specific alphanumeric word, drink, finds all the words in the text occuring directly before drink. Returns an array of strings.

####`BeverageScrapper::Find.drinkdescriptors(text, drink)`:

Returns an array of strings, representing the words used directly after a specific drink that are description words. For example, `coke tastes`, would have `tastes` returned. However, `coke and`, would not return `and` in the resulting array.

####`BeverageScrapper::Find.drinkaction(text, drink)`:

Returns an array of strings, representing the words used with a specific drink that signify an action related to drinking or beverages. For example, `drank cola` would match `drank`.

####`BeverageScrapper::Find.mostcommondrink(text, drink)`:

Returns the most commonly mentioned drink word in the text. Can either be a brand name or general name.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jweinst1/BeverageScrapper.
Also, feel free to raise any issues with the gem that you might feel need improvement.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

