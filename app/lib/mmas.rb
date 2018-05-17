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

    @problem.reset_pheromone

    NUMBER_OF_TRIES.times do
      raise TimeLimitError if time_passed?(time_start)

      ants.each(&:move!)

      @problem.evaporate_pheromone

      best_fitness = 99999
      ant_best_fitness = nil
      ants.each do |ant|
        fitness = ant.compute_fitness
        if fitness < best_fitness
          ant_best_fitness = ant
        end
      end

    end
  end

  def time_passed?(time_start)
    return true if Time.now >= time_start + TIME_LIMIT_SECONDS

    false
  end

  def ants
    Array.new(NUMBER_OF_ANTS, Ant.new(@problem))
  end
end