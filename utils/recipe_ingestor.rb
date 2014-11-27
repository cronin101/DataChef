require_relative '../db/data_source.rb'

# Inserts a blank recipe object into the database
module Ingestor
  module_function
  def push_uri(uri)
    DataSource.put(Recipe.new source_uri: uri)
  end
end
