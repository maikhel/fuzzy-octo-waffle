# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  birth_date             :date
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  index_num              :string
#  street                 :string
#  postal_code            :string
#  city                   :string
#  country                :string
#  bank_account           :string
#  role                   :string           default("Student")
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #:registerable
  self.inheritance_column = :role
  ROLES = %w{Admin Student Lecturer}

  self.per_page = 25

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :course_groups
  has_and_belongs_to_many :semesters
  has_many :grades

  validates_format_of :index_num, with: /^[0-9]/, multiline: true
  validates :first_name, :last_name, :email, presence: true


  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(index_num) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:index_num].nil?
        where(conditions).first
      else
        where(index_num: conditions[:index_num]).first
      end
    end
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.index_num || self.email
  end

  def subjects
    Subject.where(id: course_groups.pluck(:subject_id))
  end

  def field_of_studies
    semesters.includes(:field_of_study).pluck("field_of_studies.title").uniq.to_sentence
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def address
    "#{street}, #{postal_code}, #{city}"
  end

  def average_grade
    grades.average(:value).round(2) rescue nil
  end

  def enrolled?(course)
    CourseGroupJoiner.new(course).enrolled?(self)
  end

  def admin?
    false
  end

  def student?
    false
  end

  def lecturer?
    false
  end


end
