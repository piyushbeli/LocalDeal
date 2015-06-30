class CreateCompanySetting < ActiveRecord::Migration
  def change
    create_table :company_settings do |t|
      t.string :terms_and_conditions_vendor
      t.string :terms_and_conditions_user
      t.string :about_us
      t.string :contact_us
    end
  end
end
