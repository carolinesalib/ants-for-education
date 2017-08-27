class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def sync
    IeducarApi::Courses.new.sync!

    redirect_to courses_index_path
  end
end
