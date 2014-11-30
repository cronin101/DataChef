require_relative '../../environment.rb'

# The recipes table to store recipe source and information
class CreateRecipesTable < ActiveRecord::Migration
  def up
    create_table :recipes do |t|
      t.text :source_uri, null: false, index: true
      t.text :source_ingredients, array: true, null:false, default: []
      t.integer :ingredient_ids, array: true, null: false, default: []
      t.boolean :has_been_scraped, null: false, default: false
      t.text :title
      t.text :description
    end
  end

  def down
    drop_table :recipes
  end
end

CreateRecipesTable.migrate(ARGV[0])
