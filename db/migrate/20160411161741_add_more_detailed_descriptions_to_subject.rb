class AddMoreDetailedDescriptionsToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :short_description, :text
    add_column :subjects, :literature, :text
    add_column :subjects, :requirements, :text
    add_column :subjects, :learning_outcomes, :text
  end
end
