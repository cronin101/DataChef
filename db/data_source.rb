# The interface for the datasource
module DataSource
  CouchPotato::Config.database_name = 'data_chef'

  module_function

  def put(doc)
    CouchPotato.database.save_document(doc)
  end

  def get(view)
    CouchPotato.database.view view
  end
end
