class Vendor::ParameterSanitizer < Devise::ParameterSanitizer

  def attributes_for(kind)
    case kind
      when :sign_in
        auth_keys + [:password, :remember_me]
      when :sign_up
        auth_keys + [:password, :password_confirmation, :name, :mobile]
      when :account_update
        auth_keys + [:password, :password_confirmation, :current_password, :name, :website, :latitude, :longitude]
    end
  end

end