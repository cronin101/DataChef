# Represents an ingredient used within many recipes
class Ingredient < ActiveRecord::Base
  validates_presence_of :name

  def recipe_linked?(recipe_id)
    Ingredient.where(id: id).where('? = ANY (recipe_ids)', recipe_id).any?
  end

  def link_to_recipe!(recipe_id)
    tap do |i|
      fail 'Already Linked' if recipe_linked?(recipe_id)

      i.recipe_frequency += 1

      i.recipe_ids_will_change!
      i.recipe_ids << recipe_id

      i.save!
    end
  end
end
