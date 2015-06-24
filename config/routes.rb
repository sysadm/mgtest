Rails.application.routes.draw do
  resources :votes
  resources :campaigns
  resources :candidates

  root 'campaigns#index'
end
