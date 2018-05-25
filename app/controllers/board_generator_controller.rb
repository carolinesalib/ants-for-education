class BoardGeneratorController < ApplicationController
  def index
  end

  def build
    redirect_to board_generator_test_page_path
  end

  def test_page
    periods = 5
    days = 5
    school = School.find_by(name: 'TCC Escola')
    classrooms = Classroom.where(school_id: school.id)
    mmas = MMAS.new(classrooms, days, periods)
    mmas = mmas.generate

    @board = convert_mmas_to_board(mmas, classrooms, periods, days)
  end

  def convert_mmas_to_board(mmas, classrooms, periods, days)
    classrooms_node = []

    classrooms.each do |classroom|
      periods_node = []

      (1..periods).each do |period|
        days_node = []

        (1..days).each do |day|
          events_node = []
          timeslot = period - 1

          if day > 1
            timeslot += periods * (day - 1)
          end

          events = mmas.events.select { |event| event.lesson.classroom_id == classroom.id && event.timeslot == timeslot }

          # não deveria ter mais de um evento para mesma turma no mesmo timeslot
          events.each do |event|
            teacher_name = event.teacher.name if event.teacher.present?

            events_node << {
              timeslot: event.timeslot,
              discipline: event.lesson.discipline.name,
              teacher: teacher_name
            }
          end

          days_node[day] = events_node
        end
        periods_node << { days: days_node }
      end
      classrooms_node << { classroom: classroom.name, periods: periods_node }
    end

    classrooms_node
  end
end
