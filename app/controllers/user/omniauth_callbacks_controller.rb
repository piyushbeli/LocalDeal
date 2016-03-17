


class User::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  rescue_from Koala::Facebook::AuthenticationError, :with => :facebook_exception_handler

  def mobile_signin
    provider = request.params[:provider]
    if (provider == 'facebook')
      facebook_login
    elsif (provider == 'google_auth2')
      google_login
    end
    omniauth_success
    #set_user_by_token
    #update_auth_header
  end

  def facebook_login
    access_token = request.params[:access_token]
    #access_token = 'CAACEdEose0cBAEg2fDTU3rhiSpNtrpRDV9uRQQL7pRPhZC9SFj2kWBBvMAVBB4fZB4FxuThpGt5glfrktBxTIY2JFA8pPuZA7hzJxfJZCzukzNSM90MZA2Ay8ZBkaZAsSnTHG7KEwhWSsuJXWouYPZCgZAycA7QRiEreRxSvlJ0ZBu2L3CrHp8ecZAuaxNK4OqMlfvHA1RgUZBvlM2n6ZBZBOGEnR1'
    @graph = Koala::Facebook::API.new(access_token)
    profile = @graph.get_object("me")
    session['dta.omniauth.auth'] = {}
    session['dta.omniauth.auth']['info'] = {}
    session['dta.omniauth.auth']['uid'] = profile['id']
    session['dta.omniauth.auth']['provider'] = 'facebook'
    session['dta.omniauth.auth']['info']['name'] = profile['name']
    session['dta.omniauth.auth']['info']['nickname'] = profile['first_name']
    session['dta.omniauth.auth']['info']['email'] = profile['email']
    session['dta.omniauth.auth']['info']['birth_day'] = profile['birthday']
    params['resource_class'] = 'User'
  end

  def google_login
    client_id = ENV['GOOGLE_KEY']
    client_secret = ENV['GOOGLE_SECRET']
    options = {}
    options['client_id'] = client_id
    options['client_secret'] = client_secret
    #option :client_id, client_id
    #option :client_secret, client_secret

    google_oauth_s = OmniAuth::Strategies::CustomGoogleOauth2.new({})
    verifier = request.params['code']
    #google_oauth_s.client.auth_code.get_token(verifier, { :redirect_uri => 'postmessage'}.merge(google_oauth_s.token_params.to_hash(:symbolize_keys => true)),
    #                                          google_oauth_s.deep_symbolize(google_oauth_s.options.auth_token_params || {}))
    google_oauth_s.custom_build_access_token(verifier)
    session['dta.omniauth.auth'] = request.env['omniauth.auth'].except('extra')
    session['dta.omniauth.params'] = request.env['omniauth.params']
    params['resource_class'] = 'User'
  end


  def facebook_exception_handler exception
    if exception.fb_error_type.eql? 'OAuthException'
      render json: {success: false, status: 401, errors: ['Access token is expired']}
    else
      render json: {success: false, status: 401, errors: ['Unexpected error has occurred']}
    end
  end

  def render_data_or_redirect(message, data, user_data = {})
    # We handle inAppBrowser and newWindow the same, but it is nice
    # to support values in case people need custom implementations for each case
    # (For example, nbrustein does not allow new users to be created if logging in with
    # an inAppBrowser)
    #
    # See app/views/devise_token_auth/omniauth_external_window.html.erb to understand
    # why we can handle these both the same.  The view is setup to handle both cases
    # at the same time.
    if request.params['app_req']
      render :json => user_data.merge(data)
    elsif ['inAppBrowser', 'newWindow'].include?(omniauth_window_type)
      render_data(message, user_data.merge(data))

    elsif auth_origin_url # default to same-window implementation, which forwards back to auth_origin_url

      # build and redirect to destination url
      redirect_to DeviseTokenAuth::Url.generate(auth_origin_url, data)
    else

      # there SHOULD always be an auth_origin_url, but if someone does something silly
      # like coming straight to this url or refreshing the page at the wrong time, there may not be one.
      # In that case, just render in plain text the error message if there is one or otherwise
      # a generic message.
      fallback_render data[:error] || 'An error occurred'
    end
  end

end
