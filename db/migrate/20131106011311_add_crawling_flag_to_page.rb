class AddCrawlingFlagToPage < ActiveRecord::Migration
  def change
    change_table :page do |t|
      t.integer :importing_status
    end
  end
end
