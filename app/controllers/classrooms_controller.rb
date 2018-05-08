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
end
