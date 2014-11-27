# Inserts a blank recipe object into the database
module Ingestor
  module_function
  def push_uri(uri)
    CouchPotato.database.save_document(Recipe.new source_uri: uri)
  end
end
