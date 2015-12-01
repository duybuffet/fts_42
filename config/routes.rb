Rails.application.routes.draw do
  devise_for :users
  get "help" => "static_pages#help"
  resources :exams
  resources :questions, except: :show
  root "exams#index"

  namespace :admin do
    root "dashboard#home"
    resources :subjects
    resources :questions
    resources :users
    resources :exams
  end
end
