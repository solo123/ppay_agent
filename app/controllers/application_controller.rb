class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protected
    def layout_by_resource
      if devise_controller?
        "admin_login"
      else
        "application"
      end
    end

  before_action :authenticate_user!

end
