class AddSemesterIdToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :semester_id, :integer, index: true
  end
end
