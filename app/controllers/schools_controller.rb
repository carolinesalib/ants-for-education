class SchoolsController < ApplicationController
  def index
    @schools = School.all
  end

  def sync
    IeducarApi::Schools.new.sync!

    redirect_to schools_path
  end
end
