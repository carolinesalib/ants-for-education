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

    # all timeslots must have an event for all classrooms
    if timeslots_without_events_hcv > 0
      return false
    end

    true
  end

  def local_search(maxSteps = 10_000_000, ls_limit = 999_999, prob1 = 1.0, prob2 = 1.0, prob3 = 0.0)
    events_indexes = [*0..@problem.total_events - 1].shuffle

    feasible = compute_feasibility
    step = 0

    until feasible || step == 2
      step += 1
      events_indexes.each do |event_index|
        event = @problem.events[event_index]
        current_hcv = event_hard_constraints_violations(@problem, event)

        next if current_hcv.zero?

        @problem = move_one(@problem, event_index, current_hcv)
      end
      feasible = compute_feasibility
    end

    @problem
  end

  def move_one(problem, event_index, current_hcv)
    neighbour_problem = problem
    neighbour_event = neighbour_problem.events[event_index]
    # old_timeslot = neighbour_event.timeslot

    if neighbour_event.timeslot < @problem.total_timeslots - 1
      neighbour_event.timeslot += 1
    else
      neighbour_event.timeslot = 0
    end

    neighbour_event_hcv = event_hard_constraints_violations(neighbour_problem, neighbour_event)

    if neighbour_event_hcv < current_hcv
      neighbour_problem.events[event_index] = neighbour_event

      # neighbour_problem.timeslots_events[old_timeslot].delete(event_index)
      # neighbour_problem.timeslots_events[neighbour_event.timeslot].push(event_index)

      return neighbour_problem
    end

    problem
  end

  def move_two

  end

  def event_hard_constraints_violations(problem, event)
    event_hcv = 0

    event_hcv += duplicated_teacher_timeslot_hcv(problem.events, event)

    event_hcv
  end

  def timeslots_without_events_hcv
    timeslots_without_event = 0

    @problem.classrooms.each do |classroom|
      @problem.total_timeslots.times do |period|
        (1..@problem.days).each do |timeslot|

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
