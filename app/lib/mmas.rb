class MMAS
  attr_reader :classrooms, :days, :periods

  NUMBER_OF_ANTS = 10
  ALPHA = 1
  BETHA = 0
  PHEROMONE_EVAPORATION = 1
  MIN_PHEROMONE = 0
  NUMBER_OF_TRIES = 10
  TIME_LIMIT_SECONDS = 90

  def initialize(classrooms, days, periods)
    @classrooms = classrooms
    @days = days
    @periods = periods
  end

  def generate
    time_start = Time.now
    problem = Problem.new(classrooms, days, periods)

    NUMBER_OF_TRIES.times do
      raise TimeLimitError if time_passed?(time_start)

      ants.each do |ant|
        problem = ant.move!(problem)
        problem
      end
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