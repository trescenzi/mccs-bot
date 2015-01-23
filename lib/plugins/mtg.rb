require 'cinch'
require 'json'
require 'uri'

class MTG
  include Cinch::Plugin

  def titleCase(s)
    title = s.split
    title.each do |word|
      unless (word == "of") || (word == "the") || (word == "a") || (word == "and")
        word.capitalize!
      end
    end 
    title.join(" ").squeeze(" ")
  end

  match(/card (.+)/)
  def execute(m, target)
    file = File.read("cards.json");
    cards = JSON.parse(file);
    puts target
    puts titleCase(target)
    puts cards[titleCase(target)]
    card = cards[titleCase(target)]
    puts card
    link = URI::encode("http://mtgimage.com/card/"+card["imageName"]+".jpg")
    m.reply link
  end

end
