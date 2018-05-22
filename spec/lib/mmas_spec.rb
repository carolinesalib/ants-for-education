require 'rails_helper'

describe MMAS do
  let(:classrooms) { create_list(:classroom, 3) }
  let(:days) { 5 }
  let(:periods) { 5 }
  let(:disciplines) { create_list(:discipline, 5) }
  let(:teachers) { create_list(:teacher, 5) }

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

    disciplines.each do |discipline|
      teachers.each do |teacher|
        TeacherDiscipline.create(
          discipline: discipline,
          teacher: teacher
        )
      end
    end
  end

  subject { MMAS.new(classrooms, days, periods) }

  describe '#initialize' do
    it 'should contains problem' do
      expect(subject.problem).to be_a(Problem)
    end
  end

  describe '#generate_ants' do
    before do
      subject.generate_ants
    end

    it 'should return an array with total number of ants' do
      expect(subject.ants.size).to eq(MMAS::NUMBER_OF_ANTS)
    end

    it 'should contain an ant object in each array space' do
      subject.ants.each do |ant|
        expect(ant).to be_an(Ant)
      end
    end
  end

  describe '#generate' do
    it 'should raise TimeLimitError if time was passed' do
      allow(subject).to receive(:time_passed?).and_return(true)
      expect { subject.generate }.to raise_error(TimeLimitError)
    end

    it 'should not raise error' do
      expect { subject.generate }.not_to raise_error
    end
  end

  describe '#time_passed?' do
    it 'should return false if time not passed of limit' do
      expect(subject.time_passed?(Time.now)).to be_falsey
    end

    it 'should return true if time passed of limit' do
      expect(subject.time_passed?(Time.now - MMAS::TIME_LIMIT_SECONDS)).to be_truthy
    end
  end
end