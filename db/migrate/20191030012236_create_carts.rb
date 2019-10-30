class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.references :user
      t.references :ware
      t.string :carts_count

      t.timestamps
    end
  end
end
