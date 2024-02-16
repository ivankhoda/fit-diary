# frozen_string_literal: true

# == Schema Information
#
# Table name: user_exercises
#
#  id               :bigint           not null, primary key
#  name             :string
#  repetitions      :integer
#  sets             :integer
#  state            :string
#  weight           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  exercise_id      :bigint
#  telegram_user_id :bigint
#  user_workout_id  :bigint
#
# Indexes
#
#  index_user_exercises_on_exercise_id       (exercise_id)
#  index_user_exercises_on_telegram_user_id  (telegram_user_id)
#  index_user_exercises_on_user_workout_id   (user_workout_id)
#
class UserExercise < ApplicationRecord
  include AASM
  belongs_to :user_workout
  belongs_to :telegram_user
  has_many :user_exercise_set

  aasm column: :state do
    state :new, initial: true
    state :in_progress
    state :completed

    event :start do
      transitions from: :new, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :completed
    end
  end

  scope :best_records, lambda { |user|
                         select('DISTINCT ON (exercise_id) user_exercise_sets.*, user_exercises.exercise_id, user_exercises.name')
                           .where(exercise_id: Exercise::BASE_EXERCISES, telegram_user: user)
                           .joins(:user_exercise_set)
                       }
  scope :last_records, -> {}
end
