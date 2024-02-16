# frozen_string_literal: true

module Telegram
  class ReplyService
    class << self
      def reply_with_menu
        [
          [{ text: 'Подход сделан', callback_data: 'set_is_done' }],
          [{ text: 'Закончить упражнение', callback_data: 'finish_exercise' }],
          [{ text: 'Закончить тренировку', callback_data: 'end_workout' }]
        ]
      end

      def text_for(exercise)
        "#{exercise.name}, #{exercise.sets} подходов по #{exercise.repetitions} повторений с весом #{exercise.weight}"
      end
    end
  end
end
