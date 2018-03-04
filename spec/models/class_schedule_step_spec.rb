require 'rails_helper'

describe ClassScheduleStep do
  subject { create :class_schedule_step }

  describe '#start_at' do
    it 'should return start at with minutes format' do
      subject.start_at = '05:00'
      expect(subject.start_at).to eq('05:00')
    end

    it 'should return 00:00 when start_at is nil' do
      expect(subject.start_at).to eq('00:00')
    end
  end

  describe '#end_at' do
    it 'should return end at with minutes format' do
      subject.end_at = '05:00'
      expect(subject.end_at).to eq('05:00')
    end

    it 'should return 00:00 when end_at is nil' do
      expect(subject.end_at).to eq('00:00')
    end
  end
end