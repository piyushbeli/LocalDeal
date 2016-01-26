class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :deal, index: true
      t.references :offer_type, index: true
      t.integer :discount
      t.integer :actual_price
      t.string :what_you_get, null:false
      t.text :fine_print
      t.string :instruction
      t.datetime :start_at
      t.datetime :expire_at
    end
    add_foreign_key :offers, :deals
    add_foreign_key :offers, :offer_types
  end
end
