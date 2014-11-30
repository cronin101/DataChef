require '../environment.rb'
require '../scrapers/bbc_good_food_scraper.rb'

recipe = Recipe.create source_uri: 'http://www.bbcgoodfood.com/recipes/vietnamese-caramel-trout'
recipe.update_using_scraper BBCGoodFoodScraper

puts recipe.title
puts recipe.description
puts recipe.ingredient_ids.inspect

recipe.ingredient_ids.each { |i| puts((Ingredient.find i).inspect) }

=begin
Vietnamese caramel trout
A caramel base balances out the hot and salty ingredients of this Asian-inspired one-pan fish dish for two
[56, 57, 58, 59, 60, 61, 62, 63, 64]
#<Ingredient id: 56, name: "caster sugar", recipe_frequency: 1, recipe_ids: [7]>
#<Ingredient id: 57, name: "thai fish sauce", recipe_frequency: 1, recipe_ids: [7]>
#<Ingredient id: 58, name: "red chilli", recipe_frequency: 1, recipe_ids: [7]>
#<Ingredient id: 59, name: "ginger", recipe_frequency: 1, recipe_ids: [7]>
#<Ingredient id: 60, name: "rainbow trout", recipe_frequency: 1, recipe_ids: [7]>
#<Ingredient id: 61, name: "bok choi", recipe_frequency: 1, recipe_ids: [7]>
#<Ingredient id: 62, name: "juice lemon", recipe_frequency: 1, recipe_ids: [7]>
#<Ingredient id: 63, name: "coriander", recipe_frequency: 1, recipe_ids: [7]>
#<Ingredient id: 64, name: "rice", recipe_frequency: 1, recipe_ids: [7]>
=end
