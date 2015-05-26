class Spam < ActiveRecord::Base
  belongs_to :spammable, polymorphic: true
  belongs_to :spammer, polymorphic: true

  validates_presence_of :spammable, :spammer
end