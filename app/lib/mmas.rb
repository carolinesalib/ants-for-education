class MMAS
  attr_reader :problem

  NUMBER_OF_ANTS = 10
  ALPHA = 1
  BETHA = 0
  PHEROMONE_EVAPORATION = 1
  MIN_PHEROMONE = 0
  NUMBER_OF_TRIES = 10
  TIME_LIMIT_SECONDS = 90

  def initialize(classrooms, days, periods)
    @problem = Problem.new(classrooms, days, periods)
  end

  def generate
    time_start = Time.now
    best_solution = Solution.new(@problem)
    best_solution.calcule_hard_constraints_violations

    NUMBER_OF_TRIES.times do
      @problem.reset_pheromone

      raise TimeLimitError if time_passed?(time_start)

      best_fitness = 99999
      best_ant = nil
      ants.each do |ant|
        @problem = ant.move!(@problem)

        @problem.evaporate_pheromone

        fitness = ant.solution.calcule_hard_constraints_violations
        if fitness < best_fitness
          best_fitness = fitness
          best_ant = ant
        end
      end

      feasible = best_ant.solution.compute_feasibility

      if feasible
        'debug'
        # ant[ant_idx]->solution->computeScv();
        # if (ant[ant_idx]->solution->scv<=best_solution->scv) {
        #     best_solution->copy(ant[ant_idx]->solution);
        # best_solution->hcv = 0;
        # control.setCurrentCost(best_solution);
        # }
      else
        best_ant.solution.calcule_hard_constraints_violations
        if best_ant.solution.hard_constraints_violations <= best_solution.hard_constraints_violations
          best_solution = best_ant.solution
          # control.setCurrentCost(best_solution);
          # best_solution->scv = 99999;
        end

      end

      best_ant.solution = best_solution

      # @problem.pheromone_min_max
      # @problem.deposite_pheromone
    end
  end

  def time_passed?(time_start)
    return true if Time.now >= time_start + TIME_LIMIT_SECONDS

    false
  end

  def ants
    Array.new(NUMBER_OF_ANTS, Ant.new)
  end
end