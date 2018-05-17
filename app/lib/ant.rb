class Ant
  attr_accessor :problem

  def initialize(problem)
    @problem = problem
  end

  def move!
    @problem.events.size.times do |event_index|
      range = problem.sum_pheromone_for_event(event_index)

      # choose a random number between 0.0 and sum of the pheromone level
      # for this event and current sum of heuristic information
      # random = solution->rg->next() * range
      # TODO: calc next value
      random = Random.rand(range)

      total = 0.0
      timeslot = nil

      @problem.timeslots.size.times do |timeslot_index|
        total += @problem.event_timeslot_pheromone[[event_index, timeslot_index]]

        if total >= random
          timeslot = timeslot_index
          break
        end
      end

      @problem.timeslots_events[timeslot].push(event_index)
    end
    @problem
  end

  def compute_fitness
    @problem.hard_constraints_violations
  end
end