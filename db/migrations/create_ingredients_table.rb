require_relative '../../environment.rb'

# The ingredients table used to store ingredient meta-data.
class CreateIngredientsTable < ActiveRecord::Migration
  def up
    create_table :ingredients do |t|
      t.text :name, null: false, index: true
      t.integer :recipe_frequency, null: false,  default: 0
      t.integer :recipe_ids, array: true,  null: false,  default: []
    end
  end

  def down
    drop_table :ingredients
  end
end

CreateIngredientsTable.migrate(ARGV[0])
