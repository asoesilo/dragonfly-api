class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :firstname
      t.string :lastname
      t.date :birthday
      t.belongs_to :gender
      t.text :about
      t.boolean :is_online
      t.string :password_digest
      t.timestamps
    end
  end
end
