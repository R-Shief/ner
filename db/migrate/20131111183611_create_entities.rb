class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :name
      t.string :brief, limit: 3000
      t.references :entity_category, index: true

      t.timestamps
    end
  end
end
