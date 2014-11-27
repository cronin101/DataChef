require 'engtagger'

# Normalises a line from an ingredient list
module IngredientParser
  module_function

  def parse(line)
    tagger = EngTagger.new
    tagged = tagger.add_tags(line)

    tagger.get_nouns(tagged).keys.reject { |t| metadata? t }.join ' '
  end

  def metadata?(token)
    [:number_or_quantity?].map { |test| send test, token }.any?
  end

  def number_or_quantity?(token)
    # Metric units:
    m_prfxs, m_sfxs = %w(k m kilo milli) << '', %w(g gram l liter litre)
    units = m_prfxs.product(m_sfxs).map { |p, s| p + s }

    # Imperial units:
    units.concat %w(lb oz floz)

    # Spoon units:
    s_prefxs, s_sfxs = %w(tea table), ['spoon', ' spoon', '-spoon']
    units.concat s_prefxs.product(s_sfxs).map { |p, s| p + s }

    # Esoteric units:
    units.concat %w(stick splash dash knob pinch glass bottle)

    # Is the token (probably) a quantity?
    units.map { |u| /^\d*(#{u}(s)?)?$/.match token }.any?
  end
end

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
#     "eggs",
#     "pork",
#     "salt",
#     "honey"]
