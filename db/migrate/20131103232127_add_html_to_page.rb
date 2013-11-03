class AddHtmlToPage < ActiveRecord::Migration
  def change
    change_table :page do |t|
      t.text :html
      t.string :title
    end    
  end
end
