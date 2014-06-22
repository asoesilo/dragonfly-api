class CreateUserLanguages < ActiveRecord::Migration
  def change
    create_table :user_languages do |t|
      t.belongs_to :profile
      t.belongs_to :language
      t.belongs_to :proficiency
      t.belongs_to :action
      t.date :start_date
      t.timestamps
    end
  end
end
