class Discipline < ApplicationRecord
  has_many :lessons
  has_many :classrooms, through: :lessons
end
