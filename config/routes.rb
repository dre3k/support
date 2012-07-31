Support::Application.routes.draw do
  get "tickets/index"

  resources :tickets
end
