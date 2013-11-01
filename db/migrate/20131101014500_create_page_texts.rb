class CreatePageTexts < ActiveRecord::Migration
  def change
    create_table :page_texts do |t|
      t.references :page, index: true
      t.text :text

      t.timestamps
    end
  end
end
