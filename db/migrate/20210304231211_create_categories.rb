class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.text :body
      t.text :color
      t.text :img

      t.timestamps
    end
  end
end
