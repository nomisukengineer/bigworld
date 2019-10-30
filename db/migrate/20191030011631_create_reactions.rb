class CreateReactions < ActiveRecord::Migration[5.1]
  def change
    create_table :reactions do |t|
      t.string :reaction_name
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
