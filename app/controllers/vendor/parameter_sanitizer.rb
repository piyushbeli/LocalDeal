class Vendor::ParameterSanitizer < Devise::ParameterSanitizer

  def attributes_for(kind)
    case kind
      when :sign_in
        auth_keys + [:password, :remember_me]
      when :sign_up
        auth_keys + [:password, :password_confirmation, :name, :mobile, :slug]
      when :account_update
        auth_keys + [:name, :website, :category_id,
                     :subcategory_ids, :fb_page, :twitter_page, :google_plus_page, :instagram_page, :slug]

      when :update_password
        auth_keys + [:password, :password_confirmation, :current_password]
      when :update_mobile
        auth_keys + [:mobile]
      when :verify_mobile_no
        auth_keys + [:is_verified]
    end
  end

end