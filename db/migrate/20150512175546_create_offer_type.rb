class CreateOfferType < ActiveRecord::Migration
  def change
    create_table :offer_types do |t|
      t.string :type, null:false
      t.integer :discount, null:false
    end
  end
end
