class CreateOutlets < ActiveRecord::Migration
  def change
    create_table :outlets do |t|
      t.string  :name, limit:255
      t.references :vendor, index: true, foreign_key: true
      t.decimal :longitude, precision: 9, scale: 5
      t.decimal :latitude, precision: 9, scale: 5
      t.string :city, null:false
      t.string :city_id, null:false
      t.string :street, null: false
      t.string :street_id, null: false
      t.string :address, :email
      t.string :slug, null:false
      t.string :mobile, limit:10, null:false
      t.string :contact_no, limit:11
      t.timestamps null: false
    end
    add_index :outlets, [:latitude, :longitude]
    add_index :outlets, :slug, unique: true

  end
end
