require 'couch_potato'

require_relative '../utils/ingredient_parser.rb'

# Represents a recipe, taken from somewhere on the internet.
class Recipe
  include CouchPotato::Persistence

  # The recipe's source
  property :source_uri
  validates_presence_of :source_uri

  # Ingredient list as taken from the source
  property :raw_ingredients

  # Normalised ingredient list
  property :normalised_ingredients

  # Have we processed all the data?
  property :is_populated, default: false

  property :title
  property :description

  view :all, key: :source_uri
  view :unpopulated, key: :created_at,
                     conditions: 'doc.is_populated === false'

  def update_using_scraper(scraper)
    tap do |r|
      url                      = r.source_uri
      contents                 = scraper.scrape(url)

      r.title                  = contents[:title]
      r.description            = contents[:description]
      r.raw_ingredients        = contents[:ingredients]

      r.normalised_ingredients = contents[:ingredients]
          .map { |i| IngredientParser.parse i }

      r.is_populated           = true
    end
  end

  def self.oldest_unpopulated
    DataSource.get(Recipe.unpopulated(descending: false)).first
  end
end
