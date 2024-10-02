Rails.application.routes.draw do
  resources :movies do
    resources :reviews, only: [:new, :create, :index, :show]
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
