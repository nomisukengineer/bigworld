class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :ware, foreign_key: true
      t.string :order_count

      t.timestamps
    end
  end
end
