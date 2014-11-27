require 'active_support/inflector'
require 'engtagger'

# Normalises a line from an ingredient list
module IngredientParser
  module_function

  def parse(line)
    tagger = EngTagger.new
    tagged = tagger.add_tags(line.split(',').first)

    tagger
      .get_nouns(tagged)
      .keys
      .reject { |t| metadata? t }
      .map    { |t| ActiveSupport::Inflector.singularize t }
      .join ' '
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
    s_prfxs, s_sfxs = %w(tea table), ['spoon', ' spoon', '-spoon']
    units.concat s_prfxs.product(s_sfxs).map { |p, s| p + s }

    # Esoteric units:
    units.concat %w(stick splash dash knob pinch glass bottle bunch box)

    # Is the token (probably) a quantity?
    units.map { |u| /^(\d+(\.\d+)?)?(#{u}(s)?)?$/.match token }.any?
  end
end
