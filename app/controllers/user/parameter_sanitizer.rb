class User::ParameterSanitizer < Devise::ParameterSanitizer

  def attributes_for(kind)
    case kind
      when :sign_in
        auth_keys + [:password, :remember_me]
      when :sign_up
        auth_keys + [:password, :password_confirmation, :name, :role, :slug]
      when :account_update
        auth_keys + [:city_id, :city]
      when :update_mobile
        auth_keys + [:mobile]
      when :verify_mobile_no
        auth_keys + [:is_verified]
    end
  end

end