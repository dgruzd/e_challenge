class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.integer :level, limit: 2, null: false

      t.integer :member_id, null: false, index: true

      t.timestamps
    end
  end
end
