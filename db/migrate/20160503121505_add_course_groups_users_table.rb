class AddCourseGroupsUsersTable < ActiveRecord::Migration
  def change
    create_table :course_groups_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course_group, index: true

      t.timestamps null: false
    end
  end
end