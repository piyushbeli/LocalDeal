class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :title, null:false
      t.references :vendor, index: true, null:false
      t.string :description
      t.string :slug, index: true, null: false
    end
    add_foreign_key :deals, :vendors
  end
end
