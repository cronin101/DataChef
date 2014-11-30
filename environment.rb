require 'active_record'

# Connect to the database
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'big_baker')

# Load all models
(Dir.entries __dir__ + '/models')
  .select { |fn| fn.end_with? '.rb' }
  .each { |f| require_relative "./models/#{f}" }
