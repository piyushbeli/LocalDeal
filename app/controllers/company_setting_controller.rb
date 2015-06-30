class CompanySettingController < ApplicationController
  def show
    company_setting = CompanySetting.first
    render json: company_setting
  end
end