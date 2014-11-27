require 'couch_potato'

# Represents a recipe, taken from somewhere on the internet.
class Recipe
  include CouchPotato::Persistence

  # The recipe's source
  property :source_uri
  validates_presence_of :source_uri

  # Ingredient list as taken from the source
  property :raw_ingredients, default: []

  # Normalised ingredient list
  property :normalised_ingredients, default: []

  # Have we processed all the data?
  property :is_populated, default: false

  property :title
  property :description

  view :all, key: :source_uri
  view :unpopulated, key: :created_at,
                     conditions: 'doc.is_populated === false'

  def self.list
    CouchPotato.database.view Recipe.all
  end

  def self.oldest_unpopulated
    (CouchPotato.database.view Recipe.unpopulated(descending: false)).first
  end
end
