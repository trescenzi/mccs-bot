require 'cinch'
require 'google-search'

class Summon
  include Cinch::Plugin

  match(/summon (.+)/, method: :single_summon)
  def single_summon(m, query)
    image_results = Google::Search::Image.new(:query => query, :image_size => :medium, :saftey_level => :active)
    m.reply(image_results.first.uri.to_s)
  end

  match(/resummon (.+)/, method: :resummon)
  def resummon(m, query)
    image_results = Google::Search::Image.new(:query => query, :size => :medium)
    image_results = image_results.to_a
    image_results.shift
    m.reply(image_results.sample.uri.to_s)
  end
end
