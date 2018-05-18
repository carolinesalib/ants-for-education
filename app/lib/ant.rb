class Ant
  attr_accessor :solution

  def initialize
    @solution = Solution.new
  end

  def move!(problem)
    @solution.timeslots_teachers = problem.timeslots_events

    problem.events.size.times do |event_index|
      range = problem.sum_pheromone_for_event(event_index)

      # choose a random number between 0.0 and sum of the pheromone level
      # for this event and current sum of heuristic information
      # random = solution->rg->next() * range
      # TODO: calc next value
      random = Random.rand(range)

      total = 0.0
      timeslot = nil

      problem.timeslots.size.times do |timeslot_index|
        total += problem.event_timeslot_pheromone[[event_index, timeslot_index]]

        if total >= random
          timeslot = timeslot_index
          break
        end
      end

      @solution.timeslots_teachers[timeslot].push(event_index)
      problem.timeslots_events[timeslot].push(event_index)
    end

    solution.assign_teachers(problem)
    problem
  end
end

class Solution
  attr_accessor :timeslots_teachers

  # TODO:
  # criar o init event_teachers
  # calcular hard constraints
  #   - carga horária do professor
  #   - ele não pode ta em dois timeslots iguais ao mesmo tempo
  #   - não ter dois professores diferentes para a mesma disciplinas em uma mesma classe


  def assign_teachers(problem)
    problem.timeslots.size.times do |timeslot|
      problem.events.size.times do |event|
        event_index = timeslots_teachers[timeslot][event]

        return if event_index.nil?

        event = problem.events[event_index]

        unless event.teacher.present?
          event.teacher = TeacherDiscipline.where(discipline_id: event.discipline_id).first.teacher
        end
      end
    end
  end
end