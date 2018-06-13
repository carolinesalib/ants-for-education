class ImporterController < ApplicationController
  def index
  end

  def sync
    IeducarApi::Schools.new.sync!
    IeducarApi::Courses.new.sync!
    IeducarApi::Series.new.sync!
    IeducarApi::Classrooms.new.sync!
    IeducarApi::ClassroomsDisciplines.new.sync!
    IeducarApi::Teachers.new.sync!
    IeducarApi::TeachersDisciplines.new.sync!
    IeducarApi::TeachersSchools.new.sync!

    redirect_to board_generator_index_path
  rescue
    flash[:error] = 'Algo deu errado'
    redirect_to importer_index_path
  end
end