require 'nokogiri'
require 'open-uri'

class ECBfeed
  attr_accessor :url

  def initialize(options = {})
    @url = options[:url] ||= 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
  end

  def fetch
    doc = Nokogiri::XML(open(@url))
    parse doc
  end

  def parse(doc)
    dates = doc.children.first.children[2].children
    result = {}

    dates.each do |date|
      unless date.attributes.empty?
        date.children.inject(result[Date.parse(date.attributes["time"].value)] = {}) do |hash, rate|
          hash[rate.attributes["currency"].value] = rate.attributes["rate"].value
          hash
        end
      end
    end
    result
  end
end
