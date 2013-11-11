class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name, null: false
      t.string :website, null: false
      t.string :short_url, null: false

      t.timestamps
    end
  end
end
