class CreateJoinTableDealsOutlets < ActiveRecord::Migration
  def change
    create_join_table :deals, :outlets do |t|
      # t.index [:deal_id, :outlet_id]
      # t.index [:outlet_id, :deal_id]
    end
  end
end
