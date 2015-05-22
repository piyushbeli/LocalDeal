class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :deal, index: true
      t.references :offer_type, index: true
      t.integer :discount
      t.string :what_you_get
      t.text :fine_print
      t.string :instruction
      t.datetime :start_time
      t.datetime :expire_time
    end
    add_foreign_key :offers, :deals
    add_foreign_key :offers, :offer_types
  end
end
