class CreateJoinTableDealsOutlets < ActiveRecord::Migration
  def change
    create_join_table :deals, :outlets do |t|
    end
    add_index :deals_outlets, [ :deal_id, :outlet_id ], :unique => true, :name => 'by_deal_and_outlet'
  end
end
