class AddCategoryIdToActivity < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :category_id, :integer
  end
end
