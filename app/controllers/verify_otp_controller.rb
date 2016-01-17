require 'plivo'
include Plivo

class VerifyOtpController < ApplicationController

  devise_token_auth_group :member, contains: [:user, :vendor]
  before_action :authenticate_member!, :set_otp_key

  def set_otp_key
    @OTP_KEY = 'otp-' + current_member.class.name + '-' + current_member.id.to_s
  end

  def verify_me
    otp = params[:otp]
    actual_otp = Rails.cache.fetch(@OTP_KEY)

    if otp.nil?
      render :json => {'success': false, 'message': 'OTP can not be empty'}
      return
    end
    if actual_otp.nil?
      render :json => {'success': false, 'message': 'Invalid or expired OTP'}
      return
    end

    if otp == actual_otp.to_s
      current_member.set_verified(true)
      render :json => {'success': true}
    else
      render :json => {'success': false, 'message': 'OTP does not match'}
    end
  end

  def send_otp
    otp = rand(1000..9999)  #Generats a random number of length 4
    Rails.cache.write(@OTP_KEY, otp, expires_in: 3.minutes)
    p = RestAPI.new(ENV['PLIVO_AUTH_ID'], ENV['PLIVO_AUTH_TOKEN'])
    number = current_member.mobile
    params = {'src' => 'My-app',
              'dst' => '+91' + number.to_s,  #Hardcode for Indian number currently.
              'text' => otp.to_s + ' is your OTP for verification. Team \n Paylow',
              'type' => 'sms',
    }
    response = p.send_message(params)
    if response[0] != 202
      render :json => {'success': false, message: response[1]['error'].to_s}
      return
    end
    render :json => {'success': true}
  end

end