# == Schema Information
#
# Table name: subjects
#
#  id                :integer          not null, primary key
#  title             :string
#  coordinator_id    :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  description       :text
#  short_description :text
#  literature        :text
#  requirements      :text
#  learning_outcomes :text
#  semester_id       :integer
#

class Subject < ActiveRecord::Base

  has_many :course_groups, dependent: :destroy
  belongs_to :semester

  validates :semester, presence: true
  validates :title, :short_description, presence: true
end
