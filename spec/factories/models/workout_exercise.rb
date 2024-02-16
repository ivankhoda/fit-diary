# frozen_string_literal: true

FactoryBot.define do
  factory :workout_exercise, class: WorkoutExercise do
    exercise { create(:exercise) }
    repetitions { 10 }
    sets { 3 }
    weight { 80 }
  end
end
