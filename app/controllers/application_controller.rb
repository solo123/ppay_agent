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


  before_action :require_agent_login

  def require_agent_login
    # 确保已经登录
    authenticate_user!

    # 如果在注册或者登录path的时候不需要判断
    if current_user!=nil
      if current_user.agent==nil
        sign_out current_user
        flash[:error]  = "您不是注册代理商，请先注册"
        redirect_to nonlogin_index_path
      end

    end
  end
end
