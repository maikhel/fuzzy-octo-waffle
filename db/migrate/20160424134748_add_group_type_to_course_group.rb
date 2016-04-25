class AddGroupTypeToCourseGroup < ActiveRecord::Migration
  def change
    add_column :course_groups, :group_type, :string
  end
end
