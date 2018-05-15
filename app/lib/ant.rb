class Ant

  def move!(problem)
    problem.events.each do |event|
      # find the range for normalization
      range = problem.sum_pheromone_for_event(event)

    end
  end
end