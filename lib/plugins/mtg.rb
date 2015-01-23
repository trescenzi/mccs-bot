require 'cinch'
require 'json'
require 'uri'

class MTG
  include Cinch::Plugin

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
    file = File.read("cards.json");
    cards = JSON.parse(file);
    card = cards[titleCase(target)]
    link = URI::encode("http://mtgimage.com/card/"+card["imageName"]+".jpg")
    m.reply link
  end

end
