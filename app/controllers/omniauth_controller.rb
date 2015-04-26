=begin
module Override
  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
    def failure
      #handle you logic here..
      #and delegate to super.
      super
    end
  end
end=end
