module Spammer
  extend ActiveSupport::Concern

  included  do
    has_many :spams, as: :spammer
  end

end