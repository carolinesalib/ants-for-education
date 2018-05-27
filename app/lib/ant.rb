class Ant
  attr_accessor :solution

  ALPHA = 1.0
  BETHA = 2.0

  def move!(problem)
    @problem = problem
    @solution = Solution.new(@problem)
    @problem = @solution.assign_teachers(@problem)

    @problem.total_events.times do |event_index|
      sum_pheromone_for_event = @problem.sum_pheromone_for_event(event_index)

      # choose a random number between 0.0 and sum of the pheromone level
      # for this event and current sum of heuristic information
      # random = solution->rg->next() * range
      # TODO: calc next value
      random = Random.rand(sum_pheromone_for_event)

      total = 0.0
      timeslot = nil

      @problem.total_timeslots.times do |timeslot_index|

        # probability = probability(event_index, timeslot_index)
        total += @problem.event_timeslot_pheromone[[event_index, timeslot_index]]

        if total >= random
          timeslot = timeslot_index
          break
        end
      end

      @problem.events[event_index].timeslot = timeslot
      # @problem.timeslots_events[timeslot].push(event_index)
    end

    @problem
  end

  def deposite_pheromone
    @problem.total_events.times do |event_index|
      timeslot = @problem.events[event_index].timeslot
      @problem.event_timeslot_pheromone[[event_index, timeslot]] += 1.0
    end

    @problem
  end

  def probability(event_index, timeslot_index)
    pheromone = @problem.event_timeslot_pheromone[[event_index, timeslot_index]]
    event = @problem.events[event_index]
    hcv = @solution.event_hard_constraints_violations(@problem, event)
    heuristic_information = heuristic_information(hcv)

    sum_event_pheromone = @problem.sum_pheromone_for_event(event_index)

    probability = pheromone**ALPHA * heuristic_information**BETHA
    probability /= sum_event_pheromone**ALPHA * heuristic_information**BETHA

    probability
  end

  def heuristic_information(hcv)
    1 / 1 + hcv
  end
end
