class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #:registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable


  def login=(login)
    @login = login
  end

  def login
    @login || self.index_num || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(index_num) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:index_num) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

end
