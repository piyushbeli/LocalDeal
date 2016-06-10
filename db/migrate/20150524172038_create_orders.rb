class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_no
      t.string :coupon_code
      t.references :user, index: true
      t.references :vendor, index: true
      t.references :offer, index:true
      t.references :outlet, index:true
      t.string :what_you_get
      t.text :fine_print
      t.string :instruction
      t.datetime :expire_at, null:false
      t.datetime :created_at, null:false
      t.datetime :redeemed_at
      t.boolean :redeemed, default: false
    end
    add_foreign_key :orders, :users
    add_foreign_key :orders, :offers
    add_foreign_key :orders, :vendors
    add_foreign_key :orders, :outlets
  end
end
