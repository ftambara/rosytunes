Rails.application.routes.draw do
  devise_for :users
  root to: "menu_pages#home"
  get "search", to: "searches#delegate"
  resources :albums, only: %i[ index show ]
  resources :artists, only: %i[ index show ]
end
