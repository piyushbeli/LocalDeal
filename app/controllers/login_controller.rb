class LoginController < DeviseTokenAuth::OmniauthCallbacksController

  def omniauth_failure
    super
  end
end