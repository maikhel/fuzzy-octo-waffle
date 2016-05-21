class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :user_id
      t.integer :course_group_id
      t.float :value

      t.timestamps null: false

      t.index :user_id
      t.index :course_group_id
    end
  end
end
