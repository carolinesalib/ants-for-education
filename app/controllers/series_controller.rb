class SeriesController < ApplicationController
  def index
    @series = Serie.all
  end

  def sync
    IeducarApi::Series.new.sync!

    redirect_to series_index_path
  end
end
