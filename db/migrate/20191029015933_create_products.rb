class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.numeric :gender_id
      t.numeric :category_id
      t.numeric :price
      t.string :picture

      t.timestamps
    end
  end
end
