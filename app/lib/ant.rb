class Ant

  def move!(problem)
    problem.events.each do |event|
      # find the range for normalization
      pheromone_matrix = problem.event_timeslot_pheromone
      range = sum_pheromone_for_event(event, problem)

      # choose a random number between 0.0 and sum of the pheromone level
      # for this event and current sum of heuristic information
      # random = solution->rg->next() * range
      # random = Random(range)
      #
      # total = 0.0
      # timeslot = nil
      #
      # problem.timeslots.each do |timeslot|
      #   total += problem.event_timeslot_pheromone
      # end
    end
  end
end