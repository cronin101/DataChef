require_relative './test_helper'
require_relative '../utils/ingredient_parser.rb'

describe IngredientParser do
  it 'can simplify ingredients used to make a cake' do
    [# Basic          ,  Complex
      'flour', '100g of soft white flour'
    ].each_slice(2) do |simple, complex|
      assert_equal simple, IngredientParser.parse(complex)
    end
  end

  it 'can simplify meat-based feasts' do
    [# Basic          ,  Complex
      'braising steak', '1.6kg braising steaks, cut into large chunks',
      'chicken breast', '5 large chicken breasts'
    ].each_slice(2) do |simple, complex|
      assert_equal simple, IngredientParser.parse(complex)
    end
  end
end
