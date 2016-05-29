class AddSemesterIdToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :semester_id, :integer
    remove_column :registrations, :field_of_study_id, :integer

    add_index :registrations, :semester_id
  end
end
