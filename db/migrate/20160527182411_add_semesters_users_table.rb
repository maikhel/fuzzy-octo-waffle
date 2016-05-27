class AddSemestersUsersTable < ActiveRecord::Migration
  def change
    create_table :semesters_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :semester, index: true

      t.timestamps null: false
    end
  end
end
