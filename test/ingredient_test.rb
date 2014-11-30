require_relative './test_helper'
require_relative '../models/ingredient.rb'

describe Ingredient do
  it 'requires a name' do
    assert_raises(ActiveRecord::RecordInvalid) { Ingredient.new.save! }
  end

  it 'can be linked to a recipe' do
    ingredient = Ingredient.new(name: 'mock_ingredient')
      .tap { |i| i.recipe_ids = [] }

    # Mocking postgres behaviour for the newly-created instance:
    #   The "already linked" check
        def ingredient.recipe_linked?(id); false end
    #   The int[] field of recipe ids
      ingredient.instance_variable_set :@recipe_ids, []
      def ingredient.recipe_ids; @recipe_ids end

    assert_equal 0, ingredient.recipe_frequency

    RECIPE_ID = 10
    ingredient.link_to_recipe!(RECIPE_ID)

    assert_equal 1, ingredient.recipe_frequency
    assert_equal [RECIPE_ID], ingredient.recipe_ids
  end
end
