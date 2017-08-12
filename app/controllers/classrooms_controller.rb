class ClassroomsController < ApplicationController
  def index
    @classes = Classroom.all
  end

  def show
    @classroom = Classroom.find(params[:id])
  end
end
