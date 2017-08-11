class ClassroomsController < ApplicationController
  def index
    @classes = Classroom.all
  end
end
