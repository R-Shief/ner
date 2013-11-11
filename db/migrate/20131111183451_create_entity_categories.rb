class CreateEntityCategories < ActiveRecord::Migration
  def change
    create_table :entity_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
