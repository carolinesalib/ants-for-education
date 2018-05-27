class Ant
  attr_accessor :solution

  def move!(problem)
    @problem = problem
    @solution = Solution.new(@problem)

    @problem.total_events.times do |event_index|
      range = @problem.sum_pheromone_for_event(event_index)

      # choose a random number between 0.0 and sum of the pheromone level
      # for this event and current sum of heuristic information
      # random = solution->rg->next() * range
      # TODO: calc next value
      random = Random.rand(range)

      total = 0.0
      timeslot = nil

      @problem.total_timeslots.times do |timeslot_index|
        total += @problem.event_timeslot_pheromone[[event_index, timeslot_index]]

        if total >= random
          timeslot = timeslot_index
          break
        end
      end

      @problem.events[event_index].timeslot = timeslot
      # @problem.timeslots_events[timeslot].push(event_index)
    end

    @problem = @solution.assign_teachers(@problem)
    @problem
  end

  def deposite_pheromone
    (0..@problem.total_events - 1).each do |event_index|
      timeslot = @problem.events[event_index].timeslot
      @problem.event_timeslot_pheromone[[event_index, timeslot]] += 1.0
    end

    @problem
  end
end
