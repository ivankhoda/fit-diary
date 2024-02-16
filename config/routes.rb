Rails.application.routes.draw do
  # mount Motor::Admin => '/motor_admin'
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  telegram_webhook TelegramWebhooksController

  # authenticate :admin_user do
  namespace :admins do
    devise_for :admins
    authenticate :admin do
      mount Motor::Admin => '/admins'
    end
    controller 'admins/admins' do
      get '/', action: :index
    end
  end
  devise_for :users
  # end
  # devise_for :admins, controllers: { sessions: 'admins/sessions' }
  
  namespace :webapp do
    controller 'webapp' do
      get '/', action: :index
      post '/authorize', action: :authorize
    end
  end
  
end
