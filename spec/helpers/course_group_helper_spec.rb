
require 'spec_helper'

describe CourseGroupHelper do

  describe '.weekdays_select' do
    before(:all) { I18n.locale = :en }
    after(:all) { I18n.locale = I18n.default_locale }

    it 'returns array with 7 elements' do
      expect(weekdays_select).to be_a Array
      expect(weekdays_select.size).to eq 7
    end

    it 'returns array of arrays' do
      expect(weekdays_select.first).to be_a Array
      expect(weekdays_select.first.size).to eq 2
    end

    it 'first element of inner array is name' do
      expect(weekdays_select.first[0]).to eq 'Sunday'
    end

    it 'second element of inner array is value' do
      expect(weekdays_select.first[1]).to eq 0
    end

  end

  describe '.time_periods_select' do
    it 'returns array with 7 elements' do
      expect(time_periods_select).to be_a Array
      expect(time_periods_select.size).to eq 7
    end

    it 'returns array of arrays' do
      expect(time_periods_select.first).to be_a Array
      expect(time_periods_select.first.size).to eq 2
    end

    it 'first element of inner array is hours' do
      expect(time_periods_select.first[0]).to eq '8.00 - 9.30'
    end

    it 'second element of inner array is value' do
      expect(time_periods_select.first[1]).to eq 0
    end
  end

end