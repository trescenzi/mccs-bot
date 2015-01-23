require 'cinch'
require 'json'
require 'uri'

class MTG
  include Cinch::Plugin
  @@file = File.read("cards.json");
  @@cards = JSON.parse(@@file);

  def aetherize(s)
    words = s.split
    words.each do |word|
      if (word.casecmp("aether") == 0)
        word.sub!(/[Aa][Ee]/,"\u00C6")
      end
    end
    words.join(" ").squeeze(" ")
  end

  def titleCase(s)
    title = s.split
    title.each_with_index.map do |word, i|
      unless ((word == "of") || (word == "the") || (word == "a") || (word == "and") || (word == "for") || (word == "an") || (word == "to")) && i != 0
        word.capitalize!
      end
    end 
    title.join(" ").squeeze(" ")
  end

  match(/card (.+)/)
  def execute(m, target)
    puts aetherize(titleCase(target))
    card = @@cards[aetherize(titleCase(target))]
    link = URI::encode("http://mtgimage.com/card/"+card["imageName"]+".jpg")
    m.reply link
  end

end
