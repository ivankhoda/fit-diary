# == Schema Information
#
# Table name: workout_exercises
#
#  id               :bigint           not null, primary key
#  repetitions      :integer
#  repetitions_done :integer
#  sets             :integer
#  sets_done        :integer
#  weight           :integer
#  weight_done      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  exercise_id      :bigint
#  workout_id       :bigint
#
# Indexes
#
#  index_workout_exercises_on_exercise_id  (exercise_id)
#  index_workout_exercises_on_workout_id   (workout_id)
#
class WorkoutExercise < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout
end
