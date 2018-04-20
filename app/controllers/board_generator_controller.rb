class BoardGeneratorController < ApplicationController
  def index
  end

  def build
    classrooms = Classroom.limit(5)
    Aco.new(classrooms, 5, 5)
  end
end
