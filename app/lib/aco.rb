# while each_colony do
#   while each_ant do
#     build_solution (a)
#     apply_local_search (c)
#   end
#   order_solution
#   update_feromony
# end

class Aco
  def initialize(classrooms, days, periods)
    matrix = matrix(classrooms, days, periods)

    # build_solution
  end

  def matrix(classrooms, days, periods)
    matrix = []

    classrooms.each do |classroom|
      (1..days).each do |day|
        (1..periods).each do |period|
          matrix << [classroom.id, day, period]
        end
      end
    end

    matrix
  end
end
