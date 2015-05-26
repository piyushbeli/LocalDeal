module Spammable
  extend ActiveSupport::Concern

  included  do
    has_many :spams, as: :spammable
  end

end