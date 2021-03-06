require 'rails_helper'

describe NotGreatSolution do
  let(:classrooms) { create_list(:classroom, 3) }
  let(:days) { 5 }
  let(:periods) { 5 }
  let(:disciplines) { create_list(:discipline, 5) }

  before do
    classrooms.each do |classroom|
      disciplines.each do |discipline|
        Lesson.find_or_create_by!(
          discipline_id: discipline.id,
          classroom_id: classroom.id,
          credits: 5
        )
      end
    end
  end

  subject { NotGreatSolution.new(classrooms, days, periods) }

  describe '#initialize' do
    it 'should contains classrooms' do
      expect(subject.classrooms).to eq(classrooms)
    end

    it 'should contains days' do
      expect(subject.days).to eq(days)
    end

    it 'should contains periods' do
      expect(subject.periods).to eq(periods)
    end
  end

  describe '#total_timeslots' do
    it 'should return days * periods' do
      expect(subject.total_timeslots).to eq(25)
    end
  end

  describe '#valid?' do
    context 'when classrooms has the right number of lessons' do
      it 'should return true' do
        expect(subject.valid?).to be_truthy
      end
    end

    context 'when classrooms has the wrong number of lessons' do
      before do
        classrooms.each do |classroom|
          disciplines.each do |discipline|
            Lesson.find_or_create_by!(
              discipline_id: discipline.id,
              classroom_id: classroom.id,
              credits: 2
            )
          end
        end
      end

      it 'should raise a InvalidNumberLessonsError error' do
        expect { subject.valid? }.to raise_error(InvalidNumberLessonsError)
      end
    end
  end

  describe '#timeslot_matrix' do
    it 'should have 75 timeslots (25 peer classroom)' do
      expect(subject.timeslot_matrix.size).to eq(75)
    end
  end

  describe '#events_matrix' do
    it 'should return 75 events' do
      expect(subject.events_matrix.size).to eq(75)
    end
  end

  describe '#generate' do
    let(:timeslots) { subject.generate }

    it 'all timeslots should be allocad with a credit' do
      timeslots.each do |timeslot|
        expect(timeslot).to be_a(Credit)
      end
    end

    it 'should have 75 timeslots (25 peer classroom)' do
      expect(timeslots.size).to eq(75)
    end
  end
end