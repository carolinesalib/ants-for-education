require 'rails_helper'

describe 'Teacher', type: :model do
  subject { create(:teacher) }

  describe '#course_load' do
    it 'should return formated course load' do
      expect(subject.course_load).to eq('15:00')
    end
  end
end