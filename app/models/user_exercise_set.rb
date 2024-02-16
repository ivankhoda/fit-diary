# == Schema Information
#
# Table name: user_exercise_sets
#
#  id               :bigint           not null, primary key
#  repetitions      :integer
#  weight           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_exercise_id :bigint
#
# Indexes
#
#  index_user_exercise_sets_on_user_exercise_id  (user_exercise_id)
#
class UserExerciseSet < ApplicationRecord
  belongs_to :user_exercise
end
