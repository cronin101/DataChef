# Represents an ingredient used within many recipes
class Ingredient < ActiveRecord::Base
  def link_to_recipe!(recipe_id)
    if Ingredient.where(id: id).where('? = ANY (recipe_ids)', recipe_id).any?
      fail 'Already Linked'
    end
    self.recipe_frequency += 1

    recipe_ids_will_change!
    recipe_ids << recipe_id

    self.save!
  end
end
