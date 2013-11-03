class AddTitleToPageText < ActiveRecord::Migration
  def change
    change_table :page_texts do |t|
      t.string :title
    end

  end
end
