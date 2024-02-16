# frozen_string_literal: true

FactoryBot.define do
  factory :exercise, class: Exercise do
    sequence(:description) { |n| "Desc#{n}" }
    sequence(:muscle_group) { :chest }
    sequence(:name) { |n| "Name#{n}" }

    trait :muscle_group do |group|
      muscle_group { group }
    end
  end
end
