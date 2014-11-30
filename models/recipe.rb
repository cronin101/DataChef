require_relative '../utils/ingredient_parser.rb'

# Represents a recipe, taken from somewhere on the internet.
class Recipe < ActiveRecord::Base
  validates_presence_of :source_uri

  def update_using_scraper(scraper)
    tap do |r|
      url                      = r.source_uri
      contents                 = scraper.scrape(url)

      r.title                  = contents[:title]
      r.description            = contents[:description]
      r.source_ingredients     = contents[:ingredients]

      ingredients = contents[:ingredients]
          .map { |i| IngredientParser.parse i }
          .map { |name| Ingredient.find_or_create_by name: name }

      ingredients.each { |i| i.link_to_recipe! r.id }

      r.ingredient_ids_will_change!
      r.ingredient_ids = ingredients.map(&:reload).map(&:id)

      r.has_been_scraped = true
      r.save!
    end
  end

  def self.oldest_unpopulated
    DataSource.get(Recipe.unpopulated(descending: false)).first
  end
end
