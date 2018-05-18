require 'rails_helper'

describe Event do
  let(:lesson) { create(:lesson, credits: 3) }
  let(:credit) { 0 }

  subject { Event.new(lesson, credit) }

  describe '#initialize' do
    it 'should contains lesson' do
      expect(subject.lesson).to eq(lesson)
    end

    it 'should contains credit' do
      expect(subject.credit).to eq(credit)
    end
  end

  describe '#==' do
    it 'should return true if event has the same lesson id and credit values' do
      other_event = Event.new(lesson, credit)
      expect(subject == other_event).to be_truthy
    end

    it 'should return false' do
      other_event = Event.new(lesson, 1)
      expect(subject == other_event).to be_falsey
    end
  end

  describe '#discipline_id' do
    it 'should return the discipline id of lesson' do
      expect(subject.discipline_id).to eq(lesson.discipline_id)
    end
  end
end