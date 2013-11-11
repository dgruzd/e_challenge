class CreateFriendships < ActiveRecord::Migration
  def up
    create_table :friendships do |t|
      t.integer :member_id, null: false
      t.integer :friend_id, null: false, foreign_key: {references: :members}

      t.timestamps
    end
    add_index :friendships, [:member_id, :friend_id], unique: true
    execute 'ALTER TABLE friendships ADD CONSTRAINT check_ids CHECK (member_id < friend_id)'
  end

  def down
    drop_table :friendships
  end
end
