class AddPageIdToEntity < ActiveRecord::Migration
  def change
    change_table :entities do  |t|
      t.references :page, index: true

    end
  end
end
