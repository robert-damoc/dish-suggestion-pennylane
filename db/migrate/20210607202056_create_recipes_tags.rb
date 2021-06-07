class CreateRecipesTags < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes_tags do |t|
      t.belongs_to :recipe
      t.belongs_to :tag
    end
  end
end
