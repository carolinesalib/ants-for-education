require 'rails_helper'

describe Solution do

  describe '#duplicated_teacher_timeslot_hcv' do
    it 'should return 0 when not violate constrains' do
      credit = 1
      timeslot = 1
      teacher_1 = create(:teacher)
      teacher_2 = create(:teacher)
      lesson = create(:lesson)

      event_1 = Event.new(lesson, credit, timeslot)
      event_1.teacher = teacher_1

      event_2 = Event.new(lesson, credit, timeslot)
      event_2.teacher = teacher_2

      all_events = []
      all_events << event_1
      all_events << event_2

      expect(subject.duplicated_teacher_timeslot_hcv(all_events, event_1)).to eq(0)
    end

    it 'should return 1 when violate one constrains' do
      credit = 1
      timeslot = 1
      teacher_1 = create(:teacher)
      lesson = create(:lesson)

      event_1 = Event.new(lesson, credit, timeslot)
      event_1.teacher = teacher_1

      event_2 = Event.new(lesson, credit, timeslot)
      event_2.teacher = teacher_1

      all_events = []
      all_events << event_1
      all_events << event_2

      expect(subject.duplicated_teacher_timeslot_hcv(all_events, event_1)).to eq(1)
    end

    it 'should return 2 when violate two constrains' do
      credit = 1
      timeslot = 1
      teacher = create(:teacher)
      lesson = create(:lesson)

      event_1 = Event.new(lesson, credit, timeslot)
      event_1.teacher = teacher

      event_2 = Event.new(lesson, credit, timeslot)
      event_2.teacher = teacher

      event_3 = Event.new(lesson, credit, timeslot)
      event_3.teacher = teacher

      all_events = []
      all_events << event_1
      all_events << event_2
      all_events << event_3

      expect(subject.duplicated_teacher_timeslot_hcv(all_events, event_1)).to eq(2)
    end
  end
end