require 'rails_helper'

RSpec.describe Schedule, type: :model do
  it 'should not creates repeated schedules for the same teacher in the same step' do
    @classroom = Classroom.create(name: 'Class A')
    @teacher = Teacher.create(name: 'Robson')
    @class_schedule = ClassSchedule.create(name: 'Default')
    @class_schedule_step = ClassScheduleStep.create(class_schedule: @class_schedule, sequence: 1)
    @discipline = Discipline.create(name: 'Math')

    @schedule_1 = Schedule.new(
      classroom: @classroom,
      teacher: @teacher,
      class_schedule: @class_schedule,
      step: @class_schedule_step.sequence,
      discipline: @discipline)

    @schedule_2 = Schedule.new(
      classroom: @classroom,
      teacher: @teacher,
      class_schedule: @class_schedule,
      step: @class_schedule_step.sequence,
      discipline: @discipline)

    expect(@schedule_1.save).to be_truthy
    expect(@schedule_2.save).to be_falsey
  end
end
