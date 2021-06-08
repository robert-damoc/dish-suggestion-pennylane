class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string :title
      t.integer :unit
      t.binary :identifier

      t.timestamps

      t.index :title, unique: true
    end
  end
end
