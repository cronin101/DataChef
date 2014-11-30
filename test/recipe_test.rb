require_relative './test_helper'
require_relative '../models/recipe.rb'

describe Recipe do
  include Mocha::Integration::MiniTest

  it 'requires a source_uri' do
    assert_raises(ActiveRecord::RecordInvalid) { Recipe.new.save! }
  end

  MockScraper = MiniTest::Mock.new
  MockScraper.expect :scrape, ({
    title: Title = 'MockTitle',
    description: Description = 'MockDescription',
    ingredients: [Ingredient1 = 'I1', Ingredient2 = 'I2']
  }), ['source_uri']

  it 'uses a scraper to flesh out the model' do
    recipe = Recipe.new(source_uri: 'source_uri')
    #
    # Stub Ingredient.link_to_recipe!
    MockIngredient = MiniTest::Mock.new
      MockIngredient.expect :id, FirstID = 0
      MockIngredient.expect :id, SecondID = 1
    Ingredient.any_instance.stubs(:link_to_recipe!).returns (MockIngredient)

    # Mocking postgres behaviour for the newly-created instance:
    #   The int[] field of ingredient_ids
      recipe.instance_variable_set :@ingredient_ids, []
      def recipe.ingredient_ids; @ingredient_ids end
      def recipe.ingredient_ids=(is); @ingredient_ids = is end


    recipe.update_using_scraper MockScraper

    assert_equal Title, recipe.title
    assert_equal Description, recipe.description
    assert_equal [Ingredient1, Ingredient2], recipe.source_ingredients
    assert_equal true, recipe.has_been_scraped
    assert_equal [FirstID, SecondID], recipe.ingredient_ids
  end
end
