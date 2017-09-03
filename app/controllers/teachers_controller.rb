class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def sync
    IeducarApi::Teachers.new.sync!
    IeducarApi::TeachersDisciplines.new.sync!

    redirect_to teachers_path
  end
end
