# frozen_string_literal: true

# == Schema Information
#
# Table name: user_workouts
#
#  id               :bigint           not null, primary key
#  finished_at      :datetime
#  started_at       :datetime
#  state            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  telegram_user_id :bigint
#  workout_id       :bigint
#
# Indexes
#
#  index_user_workouts_on_telegram_user_id  (telegram_user_id)
#  index_user_workouts_on_workout_id        (workout_id)
#
class UserWorkout < ApplicationRecord
  include AfterCommitEverywhere
  include AASM

  belongs_to :telegram_user
  belongs_to :workout
  has_many :user_exercises

  after_save :record_user_exercises

  scope :current_workout, ->(user) { where(telegram_user: user, state: 'in_progress').last }
  scope :workout_current_exercise, -> { joins(:user_exercises).where(user_workout: self, state: 'in_progress').first }

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

  def workout_current_exercise
    joins(:user_exercises).where(user_workout: self, state: 'in_progress').first
  end

  def start_exercise
    user_exercises.first.start!
  end

  def next_exercise
    completed_exercise_id = user_exercises.where(state: 'completed').last.id

    user_exercises.where('id > ?', completed_exercise_id).first
  end

  private

  def record_user_exercises
    workout.workout_exercises.each do |workout_exercise|
      UserExercise.create(user_workout: self,
                          telegram_user: telegram_user,
                          exercise_id: workout_exercise.exercise.id,
                          name: workout_exercise.exercise.name,
                          repetitions: workout_exercise.repetitions,
                          sets: workout_exercise.sets,
                          weight: workout_exercise.weight)
    end
  end
end
