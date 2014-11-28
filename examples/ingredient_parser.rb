require '../utils/ingredient_parser.rb'

ingredients = [
  '200g of heavily salted butter',
  'six bottles of beer',
  '50ml of clotted cream',
  'plain brown flour',
  '1 oz french cheese',
  '8 large eggs',
  '2kg of salted pork',
  'a pinch of salt',
  'a tablespoon of honey'
]

ingredients.map { |i| IngredientParser.parse i }
# => ["butter",
#     "beer",
#     "clotted cream",
#     "flour",
#     "cheese",
#     "egg",
#     "pork",
#     "salt",
#     "honey"]
