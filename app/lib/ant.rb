class Ant
  attr_accessor :solution

  def move!(problem)
    @solution = Solution.new(problem)
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

    @solution.assign_teachers
    problem
  end
end
