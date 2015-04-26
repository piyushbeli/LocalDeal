Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :github,        ENV['GITHUB_KEY'],   ENV['GITHUB_SECRET'],   scope: 'email,profile'
  provider :facebook,      ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], {:client_options => {:ssl => {:verify => false}}}
  provider :google_oauth2, ENV['GOOGLE_KEY'],   ENV['GOOGLE_SECRET'], {:client_options => {:ssl => {:verify => false}}, :scope => "userinfo.email,userinfo.profile"}

  OmniAuth.config.on_failure = Proc.new do |env|
    LoginController.action(:omniauth_failure).call(env)
    #this will invoke the omniauth_failure action in UsersController.
  end

end