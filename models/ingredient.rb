# Represents an ingredient used within many recipes
class Ingredient < ActiveRecord::Base
  def link_to_recipe!(recipe_id)
    tap do |i|
      if Ingredient.where(id: i.id).where('? = ANY (recipe_ids)', recipe_id)
          .any?
        fail 'Already Linked'
      end

      i.recipe_frequency += 1

      i.recipe_ids_will_change!
      i.recipe_ids << recipe_id

      i.save!
    end
  end
end
