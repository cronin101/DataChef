require_relative './test_helper'
require_relative '../utils/ingredient_parser.rb'

describe IngredientParser do
  it 'can simplify ingredients used to make a cake' do
    assert_equal IngredientParser.parse('100g of soft white flour'), 'flour'
  end

  it 'can simplify meat-based feasts' do
    assert_equal(
      IngredientParser.parse('1.6kg braising steaks, cut into large chunks'),
      'braising steaks')
  end
end
