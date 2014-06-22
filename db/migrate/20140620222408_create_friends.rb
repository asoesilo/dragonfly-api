class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :profile1_id
      t.integer :profile2_id
      t.timestamps
    end
  end
end
