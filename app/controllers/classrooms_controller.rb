class ClassroomsController < ApplicationController
  def index
    @classes = Classroom.all
  end

  def show
    @classroom = Classroom.find(params[:id])
  end

  def sync
    IeducarApi::Classrooms.new.sync!
    IeducarApi::ClassroomsDisciplines.new.sync!

    redirect_to classrooms_path
  end

  def edit_disciplines
    lesson = Lesson.find(params[:id])
    lesson.credits = params[:credits]

    if !lesson.save
      render nothing: true, status: :bad_request
    end
  end

  def filtered_classrooms
    school_id = params[:school_id]
    course_id = params[:course_id]
    serie_id = params[:serie_id]
    classrooms = Classroom.filter(school_id, course_id, serie_id)

    response = {}

    if classrooms.present?
      response = classrooms.to_json
    end

    render json: response
  end
end
