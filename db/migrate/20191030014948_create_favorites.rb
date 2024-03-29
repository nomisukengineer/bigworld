class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :reaction, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
