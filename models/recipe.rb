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

      normalised_ingredients = contents[:ingredients]
          .map { |i| IngredientParser.parse i }

      recipe_id = id
      normalised_ingredients.each do |name|
        ingredient = (Ingredient.find_or_create_by name: name).tap do |i|
          i.recipe_frequency += 1

          i.recipe_ids_will_change!
          i.recipe_ids << recipe_id
        end
        ingredient.save!

        r.ingredient_ids_will_change!
        r.ingredient_ids << ingredient.reload.id
      end

      r.has_been_scraped = true
      r.save!
    end
  end

  def self.oldest_unpopulated
    DataSource.get(Recipe.unpopulated(descending: false)).first
  end
end
