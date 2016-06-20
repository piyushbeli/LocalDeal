class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :deal, index: true
      t.references :offer_type, index: true
      t.integer :discount, null: false
      t.integer :actual_price
      t.integer :offered_price
      t.string :what_you_get, null:false
      t.text :fine_print
      t.string :instruction
      t.integer :max_no_of_coupons, null:false
      t.boolean :closed, null: false, defaut: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false, index: true
      t.datetime :expire_at, null: false
    end
    add_foreign_key :offers, :deals
    add_foreign_key :offers, :offer_types
  end
end
