class SchoolsController < ApplicationController
  def index
    @schools = School.all
  end

  def sync
    redirect_to schools_index_path
  end
end
