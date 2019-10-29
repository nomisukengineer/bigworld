class CreateWares < ActiveRecord::Migration[5.1]
  def change
    create_table :wares do |t|
      t.references :product, foreign_key: true
      t.references :size, foreign_key: true
      t.string :amount

      t.timestamps
    end
  end
end
