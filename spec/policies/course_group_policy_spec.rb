require 'spec_helper'

describe CourseGroupPolicy do

  subject { CourseGroupPolicy.new(user, course_group) }
  let(:course_group) { create(:course_group) }

  describe '.policy' do
    context "for an admin" do
      let(:user) { build(:admin) }
      it { should pundit_permit(:new)}
      it { should pundit_permit(:create)}
      it { should pundit_permit(:edit)}
      it { should pundit_permit(:update)}
      it { should pundit_permit(:destroy)}
      it { should pundit_permit(:update_grades)}
      it { should pundit_permit(:show_grades)}
      it { should pundit_permit(:registrate)}
      it { should pundit_permit(:deregistrate)}
    end

    context "for lecturer" do
      let(:user) { build(:lecturer) }
      it { should_not pundit_permit(:new)}
      it { should_not pundit_permit(:create)}
      it { should_not pundit_permit(:edit)}
      it { should_not pundit_permit(:update)}
      it { should_not pundit_permit(:destroy)}
      it { should_not pundit_permit(:update_grades)}
      it { should_not pundit_permit(:show_grades)}
      it { should_not pundit_permit(:registrate)}
      it { should_not pundit_permit(:deregistrate)}
    end

    context "for student" do
      let(:user) { build(:student) }
      it { should_not pundit_permit(:new)}
      it { should_not pundit_permit(:create)}
      it { should_not pundit_permit(:edit)}
      it { should_not pundit_permit(:update)}
      it { should_not pundit_permit(:destroy)}
      it { should_not pundit_permit(:update_grades)}
      it { should_not pundit_permit(:show_grades)}
      it { should_not pundit_permit(:registrate)}
      it { should_not pundit_permit(:deregistrate)}
    end
  end

  # describe ".scope" do
  #   let(:scope) do
  #     SubjectPolicy::Scope.new(user, Subject).resolve
  #   end

  #   context "for an admin" do
  #     let(:user) { create(:admin) }

  #     it 'includes all Subjects' do
  #       create_list(:subject, 5)
  #       expect(scope.count).to eq(Subject.count)
  #     end
  #   end

  #   context "for lecturer" do
  #     let(:user) { create(:lecturer) }

  #     it 'includes only Subjects he coordinates' do
  #       create_list(:subject, 3)
  #       user.Subjects << Semester.last
  #       expect(scope.count).to eq 1
  #     end
  #   end

  #   context "for student" do
  #     let(:user) { create(:student) }

  #     it 'includes all Subjects' do
  #       create_list(:subject, 5)
  #       expect(scope.count).to eq(Subject.count)
  #     end
  #   end

  # end
end
