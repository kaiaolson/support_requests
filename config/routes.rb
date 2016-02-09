Rails.application.routes.draw do
  get '/support_requests/search' => 'support_requests#search'
  put '/support_requests/:id' => 'support_requests#update', as: :update_support_request
  resources :support_requests
  root 'support_requests#index'
end
