class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.integer :coordinator_id

      t.timestamps null: false
    end
  end
end
