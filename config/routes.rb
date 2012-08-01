Support::Application.routes.draw do
  get    'login',  to: 'sessions#new',     as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resource :session, :only => [:create]
  #resource :session, :only => [:create]
  resources :tickets, :constraints => { :id => /\d+/ } do
    collection do
      get '(:scope)', :to => 'tickets#index', :as => 'scoped',
        :constraints => { :scope => /unsigned|open|onhold|closed/ }
    end
  end

  root :to => 'tickets#new'
end
