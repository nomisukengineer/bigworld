class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.references :gender, foreign_key: true
      t.references :category, foreign_key: true
      t.numeric :price
      t.string :picture

      t.timestamps
    end
  end
end
