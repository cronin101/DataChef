require '../models/recipe.rb'
require '../scrapers/bbc_good_food_scraper.rb'

recipe = Recipe.new source_uri: 'http://www.bbcgoodfood.com/recipes/vietnamese-caramel-trout'

recipe.update_using_scraper BBCGoodFoodScraper
# => #<Recipe _id: "",
#         _rev: "",
#         created_at: nil,
#         updated_at: nil,
#         source_uri: "http://www.bbcgoodfood.com/recipes/vietnamese-caramel-trout",
#         raw_ingredients: ["50g golden caster sugar",
#         "1 tbsp Thai fish sauce",
#         "1 red chilli, finely sliced",
#         "large piece of ginger, finely sliced",
#         "2 rainbow trout fillets",
#         "2 heads bok choi, halved",
#         "juice ½ lemon",
#         "coriander sprigs",
#         "steamed rice, to serve"],
#         normalised_ingredients: ["caster sugar",
#         "Thai fish sauce",
#         "red chilli",
#         "ginger",
#         "rainbow trout",
#         "bok choi",
#         "lemon",
#         "coriander",
#         "rice"],
#         is_populated: true,
#         title: "Vietnamese caramel trout",
#         description: "A caramel base balances out the hot and salty ingredients of this Asian-inspired one-pan fish dish for two">
