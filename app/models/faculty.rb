# == Schema Information
#
# Table name: faculties
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Faculty < ActiveRecord::Base
  # has_one :dean, class_name: 'User'
  has_many :field_of_studies
end
