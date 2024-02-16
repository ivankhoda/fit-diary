RSpec.describe TelegramWebhooksController, telegram_bot: :rails, type: :request do
  # for old RSpec:
  # include_context 'telegram/bot/integration/rails'

  # Main method is #dispatch(update). Some helpers are:
  #   dispatch_message(text, options = {})
  #   dispatch_command(cmd, *args)

  # Available matchers can be found in Telegram::Bot::RSpec::ClientMatchers.

  describe '#start!' do
    subject { -> { dispatch_command :start } }
    it {
      should respond_with_message 'Выбери группу мышц'
    }
  end

  describe '#help!' do
    subject { -> { dispatch_command :help } }
    it {
      should respond_with_message "Привет, это бот для отслеживания тренировок базовых упражнений - жима лежа, приседаний, становой тяги.\nЧтобы выбрать тренировку нажми start"
    }
  end

  # describe 'message' do
  #   let!(:dish) { create(:dish) }
  #   subject { -> { dispatch_message('any') } }
  #   it { should respond_with_message dish.name }
  # end

  # There is context for callback queries with related matchers,
  # use :callback_query tag to include it.
  describe '#callback_query', :callback_query do
    let!(:telegram_user) { create(:telegram_user) }
    let!(:workout) { create(:workout_with_exercises) }

    context 'workout chest' do
      let!(:data) { 'workout_chest' }
      it {
        exercise = workout.workout_exercises.first
        should respond_with_message "#{exercise.exercise.name}, #{exercise.sets} подходов по #{exercise.repetitions} повторений с весом #{exercise.weight}"
      }
    end

    context '.workout_legs' do
      let!(:data) { 'workout_legs' }
      let!(:workout) { create(:workout_with_exercises, muscle_group: :legs) }
      it {
        exercise = workout.workout_exercises.first
        should respond_with_message "#{exercise.exercise.name}, #{exercise.sets} подходов по #{exercise.repetitions} повторений с весом #{exercise.weight}"
      }
    end

    context '.workout_back' do
      let!(:data) { 'workout_back' }
      let!(:workout) { create(:workout_with_exercises, muscle_group: :back) }
      it {
        exercise = workout.workout_exercises.first
        should respond_with_message "#{exercise.exercise.name}, #{exercise.sets} подходов по #{exercise.repetitions} повторений с весом #{exercise.weight}"
      }
    end

    context '.set_is_done' do
      let!(:data) { 'set_is_done' }
      it { should respond_with_message 'Введите количество повторений' }
    end

    context '.finish_exercise' do
      let!(:data) { 'finish_exercise' }
      let!(:user_workout) do
        create(:user_workout, telegram_user: telegram_user, workout: workout, state: 'in_progress')
      end
      it do
        user_workout.user_exercises.first.update!(state: :in_progress)
        e = user_workout.user_exercises.last
        should respond_with_message "#{e.name}, #{e.sets} подходов по #{e.repetitions} повторений с весом #{e.weight}"
      end
    end

    context '.end_workout' do
      let!(:data) { 'end_workout' }
      let!(:user_workout) do
        create(:user_workout, telegram_user: telegram_user, workout: workout, state: 'in_progress')
      end
      it { should respond_with_message 'Тренировка закончена' }
    end
  end
end
