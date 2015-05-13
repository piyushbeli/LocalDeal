class CreateSubCategory < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :name, null:false
      t.references :category, index: true, null: false
    end
    add_foreign_key :subcategories, :categories
  end
end
