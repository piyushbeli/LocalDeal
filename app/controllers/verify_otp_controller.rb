require 'plivo'
include Plivo

class VerifyOtpController < ApplicationController

  devise_token_auth_group :member, contains: [:user, :vendor]
  before_action :authenticate_member!, :set_otp_key

  def set_otp_key
    @OTP_KEY = 'otp-' + current_member.class.name + '-' + current_member.id.to_s
    @RESEND_OTP_ATTEMPT = 'otp-resend-' + current_member.class.name + '-' + current_member.id.to_s
  end

  def verify_mobile_no
    otp = params[:otp]
    mobile_no = params[:mobile_no]
    actual_otp_data = Rails.cache.fetch(@OTP_KEY)

    if actual_otp_data.nil?
      render json: {errors: ['OTP expired'], status: 422}
      return
    end
    if actual_otp_data[:mobile_no] != mobile_no
      render json: {errors: ['Mobile number does not match'], status: 401}
      return
    end

    if otp.nil?
      render :json => {'success': false, 'message': 'OTP can not be empty'}
      return
    end
    if actual_otp_data[:otp].nil?
      render :json => {'success': false, 'message': 'Invalid or expired OTP'}
      return
    end

    if otp == actual_otp_data[:otp].to_s
      current_member.is_verified = true
      current_member.mobile = mobile_no
      current_member.save
      Rails.cache.delete(@OTP_KEY)
      render :json => {'success': true}
    else
      render :json => {'success': false, 'message': 'OTP does not match'}
    end
  end

  def send_otp
    resent_otp_attempt = Rails.cache.fetch(@RESEND_OTP_ATTEMPT)
    if !resent_otp_attempt.nil?
      trials = resent_otp_attempt[:trials]
      if trials >= 3
        puts 'Resend OTP maximum limit reached: ' + @RESEND_OTP_ATTEMPT
        render json: {errors: ['You have already tried many times, please try again after 15 minutes if you still do not get the OTP'], status: 422}
        return
      else
        resent_otp_attempt[:trials] = trials + 1
      end
    else
      resent_otp_attempt = {trials: 1}
    end
    Rails.cache.write(@RESEND_OTP_ATTEMPT, resent_otp_attempt, expires_in: 15.minute)

    otp = rand(1000..9999)  #Generats a random number of length 4
    mobile_no = params[:mobile_no]
    Rails.cache.write(@OTP_KEY, {otp: otp, mobile_no: mobile_no}, expires_in: 5.minutes)
    p = RestAPI.new(ENV['PLIVO_AUTH_ID'], ENV['PLIVO_AUTH_TOKEN'])
    number = current_member.mobile
    params = {'src' => 'My-app',
              'dst' => '+91' + mobile_no.to_s,  #Hardcode for Indian number currently.
              'text' => otp.to_s + ' is your OTP for verification. Team \n Paylow',
              'type' => 'sms',
    }
    #response = p.send_message(params)
    response = [202]
    if response[0] != 202
      render :json => {'success': false, message: response[1]['error'].to_s}
      return
    end
    render :json => {'success': true}
  end

end