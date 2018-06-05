class BoardGeneratorController < ApplicationController
  def index
    @schools = School.all
    @courses = Course.all
    @series = Serie.all
  end

  def build
    classrooms_ids = params[:classrooms]

    if classrooms_ids
      redirect_to board_generator_test_page_path(classrooms_ids: classrooms_ids)
    else
      flash[:info] = 'Nenhuma turma selecionada.'
      redirect_to :back
    end
  end

  def test_page
    time_start = Time.now

    periods = 5
    days = 5
    classrooms = Classroom.where(id: params[:classrooms_ids])
    mmas = MMAS.new(classrooms, days, periods)
    mmas = mmas.generate

    time_finish = Time.now
    @time_diff = time_finish - time_start
    @empty_event = 0

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

          event = mmas.events.select do |event|
            event.lesson.classroom_id == classroom.id && event.timeslot == timeslot
          end.first

          unless event.present?
            @empty_event += 1
            next
          end

          teacher_name = event.teacher.name if event.teacher.present?

          events_node << {
            timeslot: event.timeslot,
            discipline: event.lesson.discipline.name,
            teacher: teacher_name
          }

          days_node[day] = events_node
        end
        periods_node << { days: days_node }
      end
      classrooms_node << { classroom: classroom.name, periods: periods_node }
    end

    classrooms_node
  end
end
