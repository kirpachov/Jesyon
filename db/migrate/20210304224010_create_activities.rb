class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.text :title
      t.text :body
      t.boolean :ispriv
      t.date :date
      t.float :time

      t.timestamps
    end
  end
end
