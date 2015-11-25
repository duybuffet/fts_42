Rails.application.routes.draw do
  devise_for :users
  get "help" => "static_pages#help"
  resources :exams
  root "exams#index"

  namespace :admin do
    root "dashboard#home"
    resources :subjects
    resources :questions
    resources :users
  end
end
