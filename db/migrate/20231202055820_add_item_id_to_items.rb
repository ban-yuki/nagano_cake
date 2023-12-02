class AddItemIdToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :item_id, :integer
  end
end
