# == Schema Information
#
# Table name: workouts
#
#  id                   :bigint           not null, primary key
#  date_for             :datetime
#  finished_at          :datetime
#  muscle_group         :integer
#  name                 :string
#  started_at           :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  workout_exercises_id :bigint
#
# Indexes
#
#  index_workouts_on_workout_exercises_id  (workout_exercises_id)
#
class Workout < ApplicationRecord
  has_many :workout_exercises
  has_many :user_workout
  enum muscle_group: %i[chest back legs general]

  scope :workout_with_type, ->(type) { where(muscle_group: type).sample }
end
