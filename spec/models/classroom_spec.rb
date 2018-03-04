require 'rails_helper'

describe Classroom do
  subject { create(:classroom) }

  describe '#start_at_humanize' do
    it 'should return date with a humanize format' do
      subject.start_at = '2000-01-01 07:30:00'
      expect(subject.start_at_humanize).to eq('07:30')
    end

    it 'should return nil when start_at does not exist' do
      expect(subject.start_at_humanize).to be_nil
    end
  end

  describe '#stop_at_humanize' do
    it 'should return date with a humanize format' do
      subject.stop_at = '2000-01-01 11:30:00'
      expect(subject.stop_at_humanize).to eq('11:30')
    end

    it 'should return nil when stop_at does not exist' do
      expect(subject.stop_at_humanize).to be_nil
    end
  end

  describe '#interval_start_humanize' do
    it 'should return date with a humanize format' do
      subject.interval_start = '2000-01-01 09:00:00'
      expect(subject.interval_start_humanize).to eq('09:00')
    end

    it 'should return nil when interval_start does not exist' do
      expect(subject.interval_start_humanize).to be_nil
    end
  end

  describe '#interval_stop_humanize' do
    it 'should return date with a humanize format' do
      subject.interval_stop = '2000-01-01 09:15:00'
      expect(subject.interval_stop_humanize).to eq('09:15')
    end

    it 'should return nil when interval_stop does not exist' do
      expect(subject.interval_stop_humanize).to be_nil
    end
  end
end