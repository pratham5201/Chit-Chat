class AddGroupToChat < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :group_id, :integer
  end
end
