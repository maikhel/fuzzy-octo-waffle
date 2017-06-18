class AddIndexToCourseGroupsUsers < ActiveRecord::Migration
  def change
    add_index :course_groups_users, %i[user_id course_group_id], unique: true, name: 'by_user_and_course_group'
  end
end
