class Aco
  NUMBER_OF_ANTS = 10

  def initialize(classrooms, days, periods)
    # test data classroom
    school = School.find(33)
    classrooms = Classroom.where(school_id: school.id)
    timeslots = timeslots(classrooms, days, periods)
    events = events(classrooms)

    min_max_as(events, timeslots)

    # as = AntColonySystemSample.new
    # as.teste_solution
    # test_data
  end

  def min_max_as(events, timeslots)
    pheromone_matrix = initialize_pheromone_matrix(events, timeslots)
    heuristic_matrix = initialize_heuristic_matrix(events, timeslots)
    shuffled_events = shuffled_events(events)

    while(true) do # list_timetable not optimized or time not reach
      NUMBER_OF_ANTS.times do |ant|
        pheromone = []
        shuffled_events.each do |event|
          # choose timeslot t randomly according to probabilities pei,t for event ei
          # verificar o que acontece na primeira formiga, pois não da de aplicar (Ai-1)
          previous_ant = ant - 1
          pheromone = pheromone_matrix[previous_ant]
          heuristic = heuristic_matrix[previous_ant]

          probability(timeslots, pheromone, heuristic)
        end
        # update pheromone
      end
      break
    end
  end

  def shuffled_events(events)
    # para este exemplo, os eventos já estão ordenados conforme suas dependências
    # ordenar por turma, disciplina
    events
  end

  def probability(pheromone, heuristic)

  end

  def initialize_heuristic_matrix(events, timeslots)
    heuristic_matrix = []

    events.size.times do |event_index|
      timeslots.size.times do |timeslot_index|
        heuristic_matrix[event_index, timeslot_index] = 0
      end
    end

    heuristic_matrix
  end

  def heuristic_information

  end

  def initialize_pheromone_matrix(events, timeslots)
    t_max = 3.3 # descobrir como calcular
    pheromone_matrix = []

    events.size.times do |event_index|
      timeslots.size.times do |timeslot_index|
        pheromone_matrix[event_index, timeslot_index] = t_max
      end
    end

    pheromone_matrix
  end

  def events(classrooms)
    events = []

    classrooms.each do |classroom|
      classroom.lessons.each do |lesson|
        lesson.credits.times do |credit|
          events << [lesson.id, credit]
        end
      end
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

  # def test_data
  #   school = School.find(7)
  #   classrooms = Classroom.where(school_id: school.id)
  #
  #   disciplines = classrooms.map { |c| c.disciplines.select(:id, :name) }.flatten.uniq
  #
  #   disciplines.each.with_index do |discipline, index|
  #     teachers = Teacher.joins('INNER JOIN teacher_schools ON teachers.id = teacher_schools.teacher_id')
  #                    .joins('INNER JOIN teacher_disciplines td ON td.teacher_id = teacher_schools.teacher_id')
  #                    .where('school_id= ? AND discipline_id= ?', school.id, discipline.id)
  #                    .select(:id, :name, :course_load)
  #                    .uniq
  #
  #     available_course_load = teachers.map{ |t| t.course_load.to_i }.inject(0, :+)
  #
  #     disciplines[index] = disciplines[index].attributes.merge(
  #       teachers_qtde: teachers.size,
  #       sum_course_load: available_course_load
  #     )
  #   end
  #
  #   disciplines
  # end
end
