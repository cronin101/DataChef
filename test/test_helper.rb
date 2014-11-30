require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'minitest/spec'
require 'minitest/autorun'

require_relative '../environment.rb'

# Mocking out Rails.root so that nulldb/rails plays nicely with MiniTest
module Rails
  module_function
  def root
    __dir__ + '/../'
  end
end
require 'nulldb/rails'

ActiveRecord::Base.establish_connection adapter: :nulldb, schema: './db/schema.rb'
