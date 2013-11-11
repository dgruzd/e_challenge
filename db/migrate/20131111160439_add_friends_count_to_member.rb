class AddFriendsCountToMember < ActiveRecord::Migration
  def change
    add_column :members, :friends_count, :integer, default: 0, null: false
  end
end
