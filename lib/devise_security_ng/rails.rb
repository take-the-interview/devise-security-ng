module DeviseSecurityNg
  class Engine < ::Rails::Engine
  	ActiveSupport.on_load(:action_controller) do
      include DeviseSecurityNg::Controllers::Helpers
    end
  end
end
