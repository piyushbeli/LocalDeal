class SpamsController < ApplicationController
  include UserResourceController

  before_filter :find_spammable

  def create
    spam = Spam.new(spammer: current_user, spammable: @spammable, reason: params[:reason])
    if spam.save
      render json:{success: true}
    else
      render json: {errors: spam.errors.full_messages}, status: 422
    end
  end

  def destroy
    spam = @spammable.spams.where(spammer: current_user).first
    if spam
      spam.destroy
      render json: {success: true}
    else
      render json: {errors: ["You have not marked it as spam"]}, status: 422
    end
  end

  def find_spammable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @spammable = $1.classify.constantize.find(value)
        if @spammable.nil?
          render json: {errors: ["Could not find the #{name} with this id"]}, status: 422
        end
      end
    end
  end

end