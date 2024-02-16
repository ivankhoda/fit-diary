# frozen_string_literal: true

module WorkoutService
  class StartWorkoutService
    def initialize(user_workout)
      @user_workout = user_workout
    end

    def execute
      user_workout.start!
      user_workout.start_exercise
      user_workout.user_exercises.where(state: 'in_progress').last
    end

    private

    attr_reader :user_workout
  end
end
