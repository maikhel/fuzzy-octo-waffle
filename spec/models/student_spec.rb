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

require 'spec_helper'

describe Student do

  it 'creates student class' do
    student = create(:student)
    expect(student).to be_a Student
  end

  describe '.student?' do
    it 'returns true' do
      user = create(:student)
      expect(user.student?).to eq true
    end
  end

end