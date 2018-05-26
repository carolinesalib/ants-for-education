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

  end

  def calcule_hard_constraints_violations
    hard_constraints_violations = 0

    # a teacher can not be in the same timeslot more than one time
    @problem.total_timeslots.times do |timeslot_index|
      teachers = []
      events = []
      @problem.total_events.times do |event_index|
        event = @problem.events[event_index]
        if event.timeslot == timeslot_index
          events << event_index
          if event.teacher.present?
            teachers << @problem.events[event_index].teacher.id
          end
        end
      end

      hard_constraints_violations += 1 if teachers.uniq.size < events.size || events.size.zero?
    end

    @hard_constraints_violations = hard_constraints_violations
  end

  def compute_feasibility
    # a teacher can not be in the same timeslot more than one time
    @problem.total_timeslots.times do |timeslot_index|
      teachers = []
      events = []
      @problem.total_events.times do |event_index|
        event = @problem.events[event_index]
        if event.timeslot == timeslot_index
          events << event_index
          if event.teacher.present?
            teachers << @problem.events[event_index].teacher.id
          end
        end
      end

      return false if teachers.uniq.size < events.size
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
  end

  def event_hard_constraints_violations(event)
    event_hcv = 0

    event_hcv += check_teacher_timeslot_hcv(@problem.events, event)

    event_hcv
  end

  def check_teacher_timeslot_hcv(all_events, current_event)
    duplicated_teacher_timeslot = -1

    all_events.each do |event|
      if event.timeslot == current_event.timeslot && event.teacher.id == current_event.teacher.id
        duplicated_teacher_timeslot += 1
      end
    end

    duplicated_teacher_timeslot
  end
end
