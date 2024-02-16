class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext

  TG_API = 'https://api.telegram.org/bot'

  def start!
    respond_with :message, text: 'Выбери группу мышц', reply_markup: {
      inline_keyboard: [
        [{ text: 'Грудь', callback_data: 'workout_chest' }],
        [{ text: 'Ноги', callback_data: 'workout_legs' }],
        [{ text: 'Спина', callback_data: 'workout_back' }]
      ]
    }
  end

  def app!
    respond_with :message, text: 'Выбери группу мышц', reply_markup: {
      inline_keyboard: [
        [{ text: 'App', web_app: { url: 'https://9rt74b-31-134-187-193.ru.tuna.am' } }]
      ]
    }
  end

  def help!
    respond_with :message, text:
      'Привет, это бот для отслеживания тренировок базовых упражнений - жима лежа, приседаний, становой тяги.
Чтобы выбрать тренировку нажми start',
                           reply_markup: {
                             inline_keyboard: [
                               [
                                 { text: 'Тренировка', callback_data: 'workout' }
                               ]
                             ]
                           }
  end

  def message(_message)
    respond_with :message, text: 'user', reply_markup: {
      inline_keyboard: [
        [
          { text: 'Тренировка', callback_data: 'workout' }
        ]
      ]
    }
  end

  def callback_query(data)
    callback_query_answer_handler(data)
  end

  def callback_query_answer_handler(data, _username = nil)
    case data
    when 'workout_chest'
      user_workout = UserWorkout.new(telegram_user: user, workout: Workout.workout_with_type(:chest))
      if user_workout.save
        first_exercise = WorkoutService::StartWorkoutService.new(user_workout).execute
        reply_with :message,
                   text: Telegram::ReplyService.text_for(first_exercise),
                   reply_markup: { inline_keyboard: Telegram::ReplyService.reply_with_menu }
      end

    when 'workout_legs'
      user_workout = UserWorkout.new(telegram_user: user, workout: Workout.workout_with_type(:legs))
      if user_workout.save
        first_exercise = WorkoutService::StartWorkoutService.new(user_workout).execute
        reply_with :message,
                   text: Telegram::ReplyService.text_for(first_exercise),
                   reply_markup: { inline_keyboard: Telegram::ReplyService.reply_with_menu }
      end
    when 'workout_back'
      user_workout = UserWorkout.new(telegram_user: user, workout: Workout.workout_with_type(:back))
      if user_workout.save
        first_exercise = WorkoutService::StartWorkoutService.new(user_workout).execute
        reply_with :message,
                   text: Telegram::ReplyService.text_for(first_exercise),
                   reply_markup: { inline_keyboard: Telegram::ReplyService.reply_with_menu }
      end
    when 'set_is_done'
      save_context :record_set_reps
      reply_with :message, text: 'Введите количество повторений'
    when 'finish_exercise'
      current_workout = UserWorkout.current_workout(user).last
      current_exercise = current_workout.user_exercises.where(state: %w[in_progress]).last
      current_exercise.complete!
      next_exercise = current_workout.next_exercise
      next_exercise.start!
      reply_with :message,
                 text: Telegram::ReplyService.text_for(next_exercise),
                 reply_markup: { inline_keyboard: Telegram::ReplyService.reply_with_menu }

    when 'end_workout'
      current_workout = UserWorkout.current_workout(user).last
      current_workout.complete!
      reply_with :message, text: 'Тренировка закончена' if current_workout.state == 'completed'
    else
      reply_with :message, text: 'Not found command'
    end
  end

  def record_set_reps(num)
    new_set = UserExerciseSet.new(
      user_exercise: UserWorkout.current_workout(user).user_exercises.where(state: 'in_progress').last, repetitions: num
    )
    if new_set.save
      save_context :record_set_weight
      reply_with :message, text: 'Введите вес'
    else
      reply_with :message, text: 'Что-то пошло не так'
    end
  end

  def record_set_weight(num)
    current_exercise = UserWorkout.current_workout(user).user_exercises.where(state: 'in_progress').last
    current_set = UserExerciseSet.where(user_exercise: current_exercise).last
    current_set.weight = num
    if current_set.save
      text = if current_exercise.sets - current_exercise.user_exercise_set.count > 0
               "Подход сохранен, осталось еще #{current_exercise.sets - current_exercise.user_exercise_set.count}"
             else
               "Уже сделано #{current_exercise.user_exercise_set.count} подходов"
             end
      reply_with :message, text: text, reply_markup: {
        inline_keyboard: [
          [{ text: 'Подход сделан', callback_data: 'set_is_done' }],
          [{ text: 'Закончить упражнение', callback_data: 'finish_exercise' }]
        ]
      }

    else
      reply_with :message, text: 'Что-то пошло не так'
    end
  end

  private

  def user
    TelegramUser.find_or_create_by(telegram_id: from['id'])
  end

  def username
    upd = HashWithIndifferentAccess.new(update)
    upd[:message][:from][:username]
  end

  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end
end
