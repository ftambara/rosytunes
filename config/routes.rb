Rails.application.routes.draw do
  devise_for :users
  root to: "static_pages#home"
  get "search", to: "searches#delegate"
  resources :albums, only: %i[ index ]
end
