require 'spec_helper'

describe UserPolicy do

  subject { UserPolicy.new(user, user) }
  let(:user) { create(:user) }

  describe '.policy' do
    context "for an admin" do
      let(:user) { build(:admin) }
      it { should pundit_permit(:new)}
      it { should pundit_permit(:create)}
      it { should pundit_permit(:edit)}
      it { should pundit_permit(:update)}
      it { should pundit_permit(:destroy)}
    end

    context "for lecturer" do
      let(:user) { build(:lecturer) }
      it { should_not pundit_permit(:new)}
      it { should_not pundit_permit(:create)}
      it { should_not pundit_permit(:edit)}
      it { should_not pundit_permit(:update)}
      it { should_not pundit_permit(:destroy)}
    end

    context "for student" do
      let(:user) { build(:student) }
      it { should_not pundit_permit(:new)}
      it { should_not pundit_permit(:create)}
      it { should_not pundit_permit(:edit)}
      it { should_not pundit_permit(:update)}
      it { should_not pundit_permit(:destroy)}
    end
  end

end
