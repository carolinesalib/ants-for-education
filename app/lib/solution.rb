class Solution
  attr_accessor :hard_constraints_violations, :soft_constraints_violations
  attr_reader :problem

  def initialize(problem = nil)
    @problem = problem

    @soft_constraints_violations = 9999
    @hard_constraints_violations = 9999
  end

  def assign_teachers(problem)
    problem.total_events.times do |event_index|
      event = problem.events[event_index]
      unless event.teacher.present?
        teacher = TeacherDiscipline.find_by(discipline_id: event.discipline_id).teacher
        problem.events[event_index].teacher = teacher
      end
    end
    problem
  end

  def calcule_soft_constraints_violations
    # nothing here yet
  end

  def calcule_hard_constraints_violations
    hard_constraints_violations = 0

    @problem.events.each do |event|
      hard_constraints_violations += duplicated_teacher_timeslot_hcv(@problem.events, event)
    end

    hard_constraints_violations += timeslots_without_events_hcv


    @hard_constraints_violations = hard_constraints_violations
  end

  def compute_feasibility
    @problem.events.each do |event|
      if duplicated_teacher_timeslot_hcv(@problem.events, event) > 0
        return false
      end
    end

    # each class must have all the timeslots allocated
    @problem.total_events.times do |event_index|
      event = @problem.events[event_index]
      unless event.timeslot
        return false
      end
    end

    true
  end

  def local_search(maxSteps = 10_000_000, ls_limit = 999_999, prob1 = 1.0, prob2 = 1.0, prob3 = 0.0)
    events = @problem.events.shuffle

    feasible = compute_feasibility

    unless feasible
      @problem.events.each do |event|
        current_hcv = event_hard_constraints_violations(event)

      end
    end

    @problem
  end

  def event_hard_constraints_violations(event)
    event_hcv = 0

    event_hcv += duplicated_teacher_timeslot_hcv(@problem.events, event)

    event_hcv
  end

  def timeslots_without_events_hcv
    timeslots_without_event = 0

    @problem.classrooms.each do |classroom|
      (1..@problem.periods).each do |period|
        (1..@problem.days).each do |day|
          timeslot = period - 1
          timeslot += @problem.periods * (day - 1) if day > 1

          event = @problem.events.select do |event|
            event.lesson.classroom_id == classroom.id && event.timeslot == timeslot
          end

          timeslots_without_event += 1 unless event.present?
        end
      end
    end

    timeslots_without_event
  end

  def duplicated_teacher_timeslot_hcv(all_events, current_event)
    duplicated_teacher_timeslot = -1

    all_events.each do |event|
      if event.timeslot == current_event.timeslot && event.teacher.id == current_event.teacher.id
        duplicated_teacher_timeslot += 1
      end
    end

    duplicated_teacher_timeslot
  end
end
