class CreateOfferType < ActiveRecord::Migration
  def change
    create_table :offer_types do |t|
      t.string :name, null:false, unique: true
      t.string :description
    end
  end
end
