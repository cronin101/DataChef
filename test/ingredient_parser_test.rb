require_relative './test_helper'
require_relative '../utils/ingredient_parser.rb'

describe IngredientParser do
  it 'can understand ingredients used to make a cake' do
    assert_equal IngredientParser.parse('100g of soft white flour'), 'flour'
  end
end
