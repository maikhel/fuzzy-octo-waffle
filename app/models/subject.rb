# == Schema Information
#
# Table name: subjects
#
#  id             :integer          not null, primary key
#  title          :string
#  coordinator_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Subject < ActiveRecord::Base

  validates :title, presence: true
end
