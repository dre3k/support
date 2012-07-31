Support::Application.routes.draw do
  get    'login',  to: 'sessions#new',     as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resource :session, :only => [:create]
  #resource :session, :only => [:create]
  resources :tickets

  root :to => 'tickets#new'
end
