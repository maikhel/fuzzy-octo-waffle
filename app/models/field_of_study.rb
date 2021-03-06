# == Schema Information
#
# Table name: field_of_studies
#
#  id         :integer          not null, primary key
#  title      :string           default("")
#  mode       :string           default("")
#  degree     :string           default("")
#  dean_id    :integer
#  faculty_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FieldOfStudy < ActiveRecord::Base
  DEGREE_TYPES = %w[master first_cycle second_cycle phd].freeze
  MODE_TYPES = %w[full_time part_time].freeze

  belongs_to :dean, class_name: 'User', foreign_key: 'dean_id'
  belongs_to :faculty
  has_many :registrations
  has_many :semesters, dependent: :destroy

  validates :title, :mode, :degree, :faculty, presence: true
  validates :degree, inclusion: { in: FieldOfStudy::DEGREE_TYPES }
  validates :mode, inclusion: { in: FieldOfStudy::MODE_TYPES }
end
