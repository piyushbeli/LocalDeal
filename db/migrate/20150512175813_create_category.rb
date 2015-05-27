class CreateCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null:false
      t.string :slug, null:false, index: true
    end
  end
end
