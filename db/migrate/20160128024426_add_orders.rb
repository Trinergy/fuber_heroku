class AddOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :cuisine
      t.string :destination
      t.date :delivery_date
      t.datetime :delivery_time
      t.integer :price
      t.string :comment
      t.references :orderer
      t.references :deliverer
      t.float :rating
      t.integer :delivery_status, default: 0
      t.timestamps null: false
    end
  end
end

#delivery datetime 
#how will we get cuisine info upon button click
#rake populate