class BoardGeneratorController < ApplicationController
  def index
  end

  def build
    classrooms = Classroom.limit(5)
    Aco.new(classrooms, 5, 5)

    redirect_to board_generator_index_path
  end
end
