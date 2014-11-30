require_relative '../utils/ingredient_parser.rb'

# Represents a recipe, taken from somewhere on the internet.
class Recipe < ActiveRecord::Base
  validates_presence_of :source_uri

  def update_using_scraper(scraper)
    tap do |r|
      contents = scraper.scrape(r.source_uri)
      r.update_from_contents(contents)

      r.has_been_scraped = true
      r.save!
    end
  end

  def update_from_contents(contents)
    self.title                  = contents[:title]
    self.description            = contents[:description]
    self.source_ingredients     = contents[:ingredients]

    self.ingredient_ids = simplified_ingredients_from_source
        .map { |i| i.link_to_recipe! id }
        .map(&:id)
  end

  def simplified_ingredients_from_source
    source_ingredients
      .map { |i| IngredientParser.parse i }
      .map { |name| Ingredient.find_or_create_by name: name }
  end

  def self.oldest_unpopulated
    DataSource.get(Recipe.unpopulated(descending: false)).first
  end
end
