module ActionDispatch::Routing
  class Mapper

    protected

    # route for handling expired passwords
    def devise_password_expired(mapping, controllers)
      resource :password_expired, :only => [:show, :update], :path => mapping.path_names[:password_expired], :controller => controllers[:password_expired]
    end

    # route for handling locked accounts
    def devise_unlock(mapping, controllers)
      resource :unlock, :only => [:show, :unlock], :path => mapping.path_names[:unlock], :controller => controllers[:user_locked]
    end

  end
end

