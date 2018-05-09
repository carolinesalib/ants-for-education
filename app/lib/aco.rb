# while each_colony do
#   while each_ant do
#     build_solution (a)
#     apply_local_search (c)
#   end
#   order_solution
#   update_feromony
# end
#
# scores base
#
# - max used time of a teacher (no need use all teachers, min better)
# - class with consecutive disciplines (3 consecutively scores 1, 4 consecutively scores 2, 2 consecutively scores 3)

class Aco
  NUMBER_OF_ANTS = 10

  def initialize(classrooms, days, periods)
    # test data classroom
    school = School.find(33)
    classrooms = Classroom.where(school_id: school.id)
    timeslots = timeslots(classrooms, days, periods)
    events = events(classrooms)

    min_max_as(events)

    # test_data
  end

  def min_max_as(events)
    (1..NUMBER_OF_ANTS).each do |index_ant|
      # construction process of ant
      events.each do |event|
        # choose timeslot t randomly according to probabilities pei,t for event ei
        event
      end
    end
  end

  def events(classrooms)
    events = []

    classrooms.each do |classroom|
      events += classroom.lessons
    end

    events
  end

  def timeslots(classrooms, days, periods)
    timeslots = []

    classrooms.each do |classroom|
      (1..days).each do |day|
        (1..periods).each do |period|
          timeslots << [classroom.id, day, period]
        end
      end
    end

    timeslots
  end

  def test_data
    school = School.find(7)
    classrooms = Classroom.where(school_id: school.id)

    disciplines = classrooms.map { |c| c.disciplines.select(:id, :name) }.flatten.uniq

    disciplines.each.with_index do |discipline, index|
      teachers = Teacher.joins('INNER JOIN teacher_schools ON teachers.id = teacher_schools.teacher_id')
                     .joins('INNER JOIN teacher_disciplines td ON td.teacher_id = teacher_schools.teacher_id')
                     .where('school_id= ? AND discipline_id= ?', school.id, discipline.id)
                     .select(:id, :name, :course_load)
                     .uniq

      available_course_load = teachers.map{ |t| t.course_load.to_i }.inject(0, :+)

      disciplines[index] = disciplines[index].attributes.merge(
        teachers_qtde: teachers.size,
        sum_course_load: available_course_load
      )
    end

    disciplines
  end
end
