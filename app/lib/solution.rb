class Solution
  attr_reader :hard_constraints_violations, :problem

  def initialize(problem)
    @problem = problem
  end

  # TODO:
  # criar o init event_teachers
  # calcular hard constraints
  #   - carga horária do professor
  #   - ele não pode ta em dois timeslots iguais ao mesmo tempo
  #   - não ter dois professores diferentes para a mesma disciplinas em uma mesma classe


  def assign_teachers
    @problem.total_timeslots.times do |timeslot|
      @problem.total_events.times do |event|
        event_index = @problem.timeslots_events[timeslot][event]

        return if event_index.nil?

        event = @problem.events[event_index]

        unless event.teacher.present?
          event.teacher = TeacherDiscipline.where(discipline_id: event.discipline_id).first.teacher
        end
      end
    end
  end


  def calcule_hard_constraints_violations
    hard_constraints_violations = 0

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
    # a professor can not be in the same timeslot more than one time
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
end
