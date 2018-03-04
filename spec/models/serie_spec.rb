require 'rails_helper'

describe 'Serie', type: :model do
  subject { create(:serie) }

  describe '#course_load' do
    it 'should return course load with correctly format' do
      expect(subject.course_load).to eq('15:00')
    end
  end
end