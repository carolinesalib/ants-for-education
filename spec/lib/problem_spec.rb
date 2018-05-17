require 'rails_helper'

describe Problem do
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

  subject { Problem.new(classrooms, days, periods) }

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

  describe '#timeslot' do
    it 'should have 25 timeslots (5 days 5 periods)' do
      expect(subject.timeslots.size).to eq(25)
    end

    # it 'should have one timeslot object in each array element' do
    #   subject.timeslots.each do |timeslot|
    #     expect(timeslot).to be_a(Timeslot)
    #   end
    # end
  end

  describe '#events' do
    it 'should return 75 events (25 peer classroom)' do
      expect(subject.events.size).to eq(75)
    end

    it 'should have one event object in each array element' do
      subject.events.each do |event|
        expect(event).to be_an(Event)
      end
    end
  end

  describe '#max_pheromone' do
    pending 'add max pheromone calc'
  end

  # describe '#sum_pheromone_for_event' do
  #   it 'should return sum pheromone for the event' do
  #     expect(subject.sum_pheromone_for_event(event)).to eq()
  #   end
  # end
end