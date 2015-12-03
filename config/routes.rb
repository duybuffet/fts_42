Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  get "help" => "static_pages#help"
  resources :exams
  resources :questions, except: :show
  root "exams#index"
  match "/users/:id/finish_signup", to: "users#finish_signup", via: [:get, :patch], as: :finish_signup

  namespace :admin do
    root "dashboard#home"
    resources :subjects
    resources :questions
    resources :users
    resources :exams
  end
end
