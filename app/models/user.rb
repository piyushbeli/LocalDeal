class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  include Spammable
  include Spammer
  acts_as_marker
  ratyrate_rater

  devise :timeoutable, :timeout_in => 30.days
  validates :name, presence: true, allow_blank: false
  validates :mobile, length: {is: 10}, numericality: {only_integer: true}, uniqueness: true, allow_nil: true

  has_many :comments, as: :commentator
  has_many :orders

  def as_json(options={})
    super(options.merge(
              except: [:created_at, updated_at],
              include: {
                  favorite_categories: {

                  }
              }
          ))
  end


  def alreadyBoughtTheOffer? (offer)
    user_offer = orders.select { |order| order.offer_id == offer.id}
    !user_offer.blank?
  end

  def isProfileComplete?
    !(email.blank? || mobile.blank? || name.blank?)
  end
end
