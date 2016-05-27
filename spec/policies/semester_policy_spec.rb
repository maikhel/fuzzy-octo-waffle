require 'spec_helper'

describe SemesterPolicy do

  subject { SemesterPolicy.new(user, semester) }
  let(:semester) { create(:semester) }

  describe '.policy' do
    context "for an admin" do
      let(:user) { build(:admin) }
      it { should pundit_permit(:index)}
    end

    context "for lecturer" do
      let(:user) { build(:lecturer) }
      it { should pundit_permit(:index)}
    end

    context "for student" do
      let(:user) { build(:student) }
      it { should pundit_permit(:index)}
    end
  end

  describe ".scope" do
    let(:scope) do
      SemesterPolicy::Scope.new(user, Semester).resolve
    end

    context "for an admin" do
      let(:user) { create(:admin) }
      it 'includes all Semesters' do
        create_list(:semester, 5)
        expect(scope.count).to eq(Semester.count)
      end
    end

    context "for lecturer" do
      let(:user) { create(:lecturer) }

      it 'includes only Semesters he belongs to' do
        create_list(:semester, 3)
        user.semesters << Semester.last
        expect(scope.count).to eq 1
      end
    end

    context "for student" do
      let(:user) { create(:student) }

      it 'includes only Semesters he belongs to' do
        create_list(:semester, 3)
        user.semesters << Semester.last
        user.reload
        expect(scope.count).to eq 1
      end
    end

  end
end
