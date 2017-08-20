class ChangeCourseLoadTypeInSeries < ActiveRecord::Migration[5.0]
  def change
    change_column :series, :course_load, :integer
  end
end
