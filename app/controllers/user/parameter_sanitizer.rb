class User::ParameterSanitizer < Devise::ParameterSanitizer

  def attributes_for(kind)
    case kind
      when :sign_in
        auth_keys + [:password, :remember_me]
      when :sign_up
        auth_keys + [:password, :password_confirmation, :name, :role, :slug]
      when :account_update
        auth_keys + [:password, :password_confirmation, :current_password, :email, :mobile, :city_id, :city, :slug]
    end
  end

end