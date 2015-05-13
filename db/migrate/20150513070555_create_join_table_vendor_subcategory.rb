class CreateJoinTableVendorSubcategory < ActiveRecord::Migration
  def change
    create_join_table :vendors, :subcategories do |t|
      # t.index [:vendor_id, :subcategory_id]
      # t.index [:subcategory_id, :vendor_id]
    end
  end
end
