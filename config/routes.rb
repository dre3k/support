class TicketsConstraint
  REAL_ID_REGEX = /\A\d+\Z/
  URL_ID_REGEX  = /\A[a-f0-9]{40}\Z/
  def self.matches?(request)
    if request.params[:action] == 'show'
      id = request.params[:id]
      if request.session[:member_id]
        return id =~ REAL_ID_REGEX
      else
        return id =~ URL_ID_REGEX
      end
    elsif request.params[:action] == 'index'
      return request.session[:member_id]
    end
    return true
  end
end

Support::Application.routes.draw do
  root :to => 'tickets#new',   :constraints => lambda { |req| !req.session[:member_id] }
  root :to => 'tickets#index', :constraints => lambda { |req|  req.session[:member_id] }

  get    'login',  to: 'sessions#new',     as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resource :session, :only => [:create]
  resources :tickets, :constraints => TicketsConstraint do
    collection do
      get '(:scope)', :to => 'tickets#index', :as => 'scoped',
        :constraints => { :scope => /unsigned|open|onhold|closed/ }
      post 'search'
    end
  end

end
