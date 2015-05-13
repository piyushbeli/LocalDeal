class CreateVendorImage < ActiveRecord::Migration
  def change
    create_table :vendor_images do |t|
      t.string :url, null:false
      t.references :vendor, index: true, null:false
      t.string :caption
    end
    add_foreign_key :vendor_images, :vendors
  end
end
