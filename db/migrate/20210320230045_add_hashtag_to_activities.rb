class AddHashtagToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :hashtag, :text
  end
end
