require './environment.rb'

ActiveRecord::SchemaDumper.dump ActiveRecord::Base.connection, File.open("#{__dir__}/db/schema.rb", 'w')
