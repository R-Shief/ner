class AddHtmlToText < ActiveRecord::Migration
  def change
    change_table :page_texts do |t|
      t.text :html
    end
  end
end
