# == Schema Information
#
# Table name: exercises
#
#  id           :bigint           not null, primary key
#  description  :text
#  muscle_group :integer
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Exercise < ApplicationRecord
  SQUAT = 1
  BENCH_PRESS = 2
  DEADLIFT = 5

  BASE_EXERCISES = [BENCH_PRESS, DEADLIFT, SQUAT]

  has_many :workout_exercises
  enum muscle_group: %i[chest back legs general]
end
