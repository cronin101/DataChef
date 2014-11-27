require 'couch_potato'

require './utils/ingredient_parser.rb'
require './utils/recipe_ingestor.rb'
require './models/recipe.rb'

CouchPotato::Config.database_name = 'data_chef'
