require 'mechanize'

# A scraper for the BBC Good Food Website
module BBCGoodFoodScraper
  module_function
  def scrape(url)
    page = Mechanize.new.get(url)

    {
      title: page.search("//h1[@itemprop = 'name']").first.text,

      description: page.search("//p[@itemprop = 'description']").first.text,

      ingredients: page.search("//li[@itemprop = 'ingredients']").map(&:text)
    }
  end
end
